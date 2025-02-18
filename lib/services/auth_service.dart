import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models.dart' as models;

class AuthService {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<firebase.User?> get authStateChanges => _auth.authStateChanges();

  Future<models.User?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    final doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
    if (!doc.exists) return null;

    final data = doc.data()!;
    return models.User(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
      name: data['name'] ?? firebaseUser.displayName ?? 'User',
      photoUrl: data['photoUrl'] ?? firebaseUser.photoURL,
      favoriteIds: List<String>.from(data['favoriteIds'] ?? []),
      addresses: (data['addresses'] as List<dynamic>? ?? [])
          .map((addr) => models.Address(
                id: addr['id'],
                name: addr['name'],
                street: addr['street'],
                city: addr['city'],
                state: addr['state'],
                zipCode: addr['zipCode'],
                country: addr['country'],
                isDefault: addr['isDefault'] ?? false,
              ))
          .toList(),
    );
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _ensureUserDocument(userCredential.user!);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signUpWithEmail(String name, String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await userCredential.user!.updateDisplayName(name);
      await _createUserDocument(userCredential.user!, name);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = firebase.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      await _ensureUserDocument(userCredential.user!);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = firebase.OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      await _ensureUserDocument(userCredential.user!);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> _ensureUserDocument(firebase.User firebaseUser) async {
    final userDoc = _firestore.collection('users').doc(firebaseUser.uid);
    final doc = await userDoc.get();

    if (!doc.exists) {
      await _createUserDocument(firebaseUser, firebaseUser.displayName ?? 'User');
    }
  }

  Future<void> _createUserDocument(firebase.User firebaseUser, String name) async {
    await _firestore.collection('users').doc(firebaseUser.uid).set({
      'name': name,
      'email': firebaseUser.email,
      'photoUrl': firebaseUser.photoURL,
      'favoriteIds': [],
      'addresses': [],
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUserProfile(String name, String? photoUrl) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await Future.wait([
      user.updateDisplayName(name),
      if (photoUrl != null) user.updatePhotoURL(photoUrl),
      _firestore.collection('users').doc(user.uid).update({
        'name': name,
        if (photoUrl != null) 'photoUrl': photoUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }),
    ]);
  }

  Future<void> updateUserAddress(models.Address address) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).update({
      'addresses': FieldValue.arrayUnion([
        {
          'id': address.id,
          'name': address.name,
          'street': address.street,
          'city': address.city,
          'state': address.state,
          'zipCode': address.zipCode,
          'country': address.country,
          'isDefault': address.isDefault,
        }
      ]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  String _handleAuthError(dynamic error) {
    if (error is firebase.FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'operation-not-allowed':
          return 'This sign in method is not enabled.';
        case 'user-disabled':
          return 'This account has been disabled.';
        default:
          return 'An error occurred. Please try again.';
      }
    }
    return error.toString();
  }
}

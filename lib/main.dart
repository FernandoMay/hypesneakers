import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/app_state.dart';
import 'styles.dart';
import 'base.dart';
import 'search.dart';
import 'cart.dart';
import 'auth/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Hype Sneakers',
      theme: CupertinoThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        barBackgroundColor: AppColors.cardBackground,
        textTheme: CupertinoTextThemeData(
          primaryColor: AppColors.textPrimary,
          textStyle: AppTextStyles.bodyMedium,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<AppState>(
        builder: (context, appState, child) {
          if (!appState.isInitialized) {
            return const CupertinoPageScaffold(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (!appState.isAuthenticated) {
            return const AuthPage();
          }

          return const MainScreen();
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const _tabItems = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      label: 'Profile',
    ),
  ];

  Widget _buildTabView(int index) {
    switch (index) {
      case 0:
        return const Base(title: 'Home');
      case 1:
        return const SearchPage();
      case 2:
        return const CartPage();
      case 3:
        return ProfilePage();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: AppColors.accent,
        backgroundColor: AppColors.cardBackground,
        items: _tabItems,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => _buildTabView(index),
        );
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final user = appState.user!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Profile'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.square_arrow_right),
          onPressed: () => appState.signOut(),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: AppTheme.borderRadius,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  if (user.photoUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        user.photoUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          user.name[0].toUpperCase(),
                          style: AppTextStyles.displayLarge.copyWith(
                            color: AppColors.cardBackground,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: AppTextStyles.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Orders',
              items: [
                _buildMenuItem(
                  icon: CupertinoIcons.cube_box,
                  title: 'My Orders',
                  onTap: () {
                    // Navigate to orders
                  },
                ),
                _buildMenuItem(
                  icon: CupertinoIcons.location,
                  title: 'Shipping Addresses',
                  onTap: () {
                    // Navigate to addresses
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Settings',
              items: [
                _buildMenuItem(
                  icon: CupertinoIcons.person,
                  title: 'Edit Profile',
                  onTap: () {
                    // Navigate to profile edit
                  },
                ),
                _buildMenuItem(
                  icon: CupertinoIcons.bell,
                  title: 'Notifications',
                  onTap: () {
                    // Navigate to notifications
                  },
                ),
                _buildMenuItem(
                  icon: CupertinoIcons.lock,
                  title: 'Privacy',
                  onTap: () {
                    // Navigate to privacy
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: AppTextStyles.titleMedium,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: AppTheme.borderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.divider,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium,
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              color: AppColors.textLight,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showEditProfileDialog(BuildContext context, AppState appState) {
    final nameController = TextEditingController(text: appState.user?.name);
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            children: [
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Name',
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              child: const Text('Save'),
              onPressed: () async {
                await appState.updateUserProfile(nameController.text, null);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
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
            CupertinoButton(
              onPressed: () => _showEditProfileDialog(context, appState),
              child: Text('Edit Profile'),
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
}

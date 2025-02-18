import 'package:flutter/cupertino.dart';
import '../styles.dart';
import '../services/app_state.dart';
import 'package:provider/provider.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool locationServices = true;
  bool analytics = true;
  bool personalization = true;
  bool marketing = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Privacy Settings'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data Collection',
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildPrivacyToggle(
                    'Location Services',
                    'Allow app to access your location for better shopping experience',
                    locationServices,
                    (value) => setState(() => locationServices = value),
                  ),
                  _buildPrivacyToggle(
                    'Analytics',
                    'Help us improve by sharing usage data',
                    analytics,
                    (value) => setState(() => analytics = value),
                  ),
                  _buildPrivacyToggle(
                    'Personalization',
                    'Receive personalized recommendations',
                    personalization,
                    (value) => setState(() => personalization = value),
                  ),
                  _buildPrivacyToggle(
                    'Marketing',
                    'Receive marketing communications',
                    marketing,
                    (value) => setState(() => marketing = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showChangePasswordDialog(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Password',
                          style: AppTextStyles.bodyMedium,
                        ),
                        const Icon(
                          CupertinoIcons.chevron_right,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showDeleteAccountDialog(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delete Account',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: CupertinoColors.destructiveRed,
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.chevron_right,
                          size: 20,
                          color: CupertinoColors.destructiveRed,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Legal',
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildLegalLink('Privacy Policy'),
                  _buildLegalLink('Terms of Service'),
                  _buildLegalLink('Data Usage'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium,
              ),
              CupertinoSwitch(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.accent,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLink(String title) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // Navigate to respective legal page
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium,
          ),
          const Icon(
            CupertinoIcons.chevron_right,
            size: 20,
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Change Password'),
          content: Column(
            children: [
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: currentPasswordController,
                placeholder: 'Current Password',
                obscureText: true,
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: newPasswordController,
                placeholder: 'New Password',
                obscureText: true,
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: confirmPasswordController,
                placeholder: 'Confirm New Password',
                obscureText: true,
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              child: const Text('Change'),
              onPressed: () {
                // Implement password change logic
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Delete'),
              onPressed: () {
                // Implement account deletion logic
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

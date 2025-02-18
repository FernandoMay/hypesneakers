import 'package:flutter/cupertino.dart';
import '../styles.dart';
import '../services/app_state.dart';
import '../models.dart';
import 'package:provider/provider.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Shipping Addresses'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add),
          onPressed: () => _showAddAddressDialog(context, appState),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (appState.user?.address != null)
              _AddressCard(address: appState.user!.address!)
            else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: AppTheme.borderRadius,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'No addresses added yet',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context, AppState appState) {
    final streetController = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final zipController = TextEditingController();
    final countryController = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Add New Address'),
          content: Column(
            children: [
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: streetController,
                placeholder: 'Street Address',
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: cityController,
                placeholder: 'City',
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: stateController,
                placeholder: 'State',
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: zipController,
                placeholder: 'ZIP Code',
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: countryController,
                placeholder: 'Country',
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
                final address = Address(
                  street: streetController.text,
                  city: cityController.text,
                  state: stateController.text,
                  zipCode: zipController.text,
                  country: countryController.text,
                );
                await appState.updateUserAddress(address);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class _AddressCard extends StatelessWidget {
  final Address address;

  const _AddressCard({required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: AppTheme.borderRadius,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Default Address',
                style: AppTextStyles.titleSmall,
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.pencil,
                  size: 20,
                ),
                onPressed: () {
                  // Show edit address dialog
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            address.street,
            style: AppTextStyles.bodyMedium,
          ),
          Text(
            '${address.city}, ${address.state} ${address.zipCode}',
            style: AppTextStyles.bodyMedium,
          ),
          Text(
            address.country,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

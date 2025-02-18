import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'styles.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller, {
    bool isSecure = false,
    TextInputType keyboardType = TextInputType.text,
    String? placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: controller,
          placeholder: placeholder ?? label,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
            borderRadius: AppTheme.borderRadius,
          ),
          obscureText: isSecure,
          keyboardType: keyboardType,
          style: AppTextStyles.bodyMedium,
          placeholderStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildOrderSummary(AppState appState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: AppTheme.borderRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: AppTextStyles.bodyMedium,
              ),
              Text(
                '\$${appState.cartTotal.toStringAsFixed(2)}',
                style: AppTextStyles.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping',
                style: AppTextStyles.bodyMedium,
              ),
              Text(
                '\$10.00',
                style: AppTextStyles.titleSmall,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              height: 1,
              color: AppColors.divider,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.titleMedium,
              ),
              Text(
                '\$${(appState.cartTotal + 10).toStringAsFixed(2)}',
                style: AppTextStyles.price,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _processPayment(BuildContext context, AppState appState) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Processing Payment'),
        content: Column(
          children: [
            const SizedBox(height: 16),
            const CupertinoActivityIndicator(),
            const SizedBox(height: 16),
            Text(
              'Please wait while we process your payment...',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close processing dialog
      
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Order Confirmed'),
          content: Column(
            children: [
              const SizedBox(height: 16),
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: AppColors.success,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Thank you for your purchase!',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                appState.clearCart();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Checkout'),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderSummary(appState),
                  const SizedBox(height: 24),
                  Text(
                    'Shipping Information',
                    style: AppTextStyles.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildFormField('Full Name', _nameController),
                  _buildFormField(
                    'Email',
                    _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildFormField(
                    'Shipping Address',
                    _addressController,
                    keyboardType: TextInputType.streetAddress,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Payment Information',
                    style: AppTextStyles.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildFormField(
                    'Card Number',
                    _cardNumberController,
                    keyboardType: TextInputType.number,
                    placeholder: '4242 4242 4242 4242',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFormField(
                          'Expiry Date',
                          _expiryController,
                          placeholder: 'MM/YY',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildFormField(
                          'CVV',
                          _cvvController,
                          isSecure: true,
                          placeholder: '123',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: () => _processPayment(context, appState),
                      child: Text(
                        'Pay \$${(appState.cartTotal + 10).toStringAsFixed(2)}',
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

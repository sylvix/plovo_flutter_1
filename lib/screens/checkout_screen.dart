import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/providers/cart_provider.dart';
import 'package:plovo/providers/order_provider.dart';
import 'package:plovo/providers/restaurant_provider.dart';
import 'package:plovo/providers/user_provider.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/address_form/address_form.dart';
import 'package:plovo/widgets/address_form/address_form_controller.dart';
import 'package:plovo/widgets/checkout_card.dart';
import 'package:plovo/widgets/checkout_cart_dish_item.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final addressFormController = AddressFormController();

  @override
  void initState() {
    super.initState();

    final user = ref.read(userProvider);
    if (user != null) {
      addressFormController.setUser(user);
    }
  }

  void goBackToRestaurant() async {
    Navigator.of(context).popUntil((p) => p.settings.name == AppRoutes.dishes);
  }

  void placeOrder() {
    if (addressFormController.formKey.currentState!.validate()) {
      final user = addressFormController.getUser();
      ref.read(userProvider.notifier).state = user;
      final restaurantId = ModalRoute.of(context)!.settings.arguments as String;
      ref.read(createOrderProvider.notifier).createOrder(restaurantId);
    }
  }

  void listenForCreateNotifier() {
    ref.listen(createOrderProvider, (prev, next) {
      next.whenOrNull(
        data: (d) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order created successfully!')),
          );
        },
        error: (e, stack) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Something went wrong!')));
        },
      );
    });
  }

  @override
  void dispose() {
    addressFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;
    final restaurant = ref.watch(restaurantByIdProvider(restaurantId));
    final cart = ref.watch(cartByRestaurantIdProvider(restaurantId));
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final createOrderState = ref.watch(createOrderProvider);

    listenForCreateNotifier();

    return Scaffold(
      appBar: AppBar(title: Text('Checkout - ${restaurant.name}')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 16, bottom: bottomPadding + 60),
                child: Column(
                  children: [
                    CheckoutCard(
                      title: 'Your order',
                      subtitle:
                          '${cart.totalItems} items from ${restaurant.name}',
                      action: IconButton(
                        onPressed: goBackToRestaurant,
                        icon: Icon(Icons.storefront),
                      ),
                      children:
                          cart.cartDishes
                              .map((cd) => CheckoutCartDishItem(cartDish: cd))
                              .toList(),
                    ),
                    SizedBox(height: 16),
                    CheckoutCard(
                      initiallyExpanded: true,
                      title: 'Your address',
                      subtitle: 'Enter your delivery details',
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 8,
                          ),
                          child: AddressForm(controller: addressFormController),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    CheckoutCard(
                      initiallyExpanded: true,
                      title: 'Summary',
                      subtitle: 'Check the total of your order',
                      children: [
                        Text('Total items'),
                        Text('Delivery'),
                        Text('Total'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ActionButton(
              onPressed: placeOrder,
              isLoading: createOrderState.isLoading,
              child: Text('Place order'),
            ),
          ],
        ),
      ),
    );
  }
}

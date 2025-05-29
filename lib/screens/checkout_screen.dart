import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/models/order.dart';
import 'package:plovo/providers/cart_provider.dart';
import 'package:plovo/providers/order_provider.dart';
import 'package:plovo/providers/restaurant_provider.dart';
import 'package:plovo/providers/user_provider.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/address_form/address_form.dart';
import 'package:plovo/widgets/address_form/address_form_controller.dart';
import 'package:plovo/widgets/checkout_card.dart';
import 'package:plovo/widgets/checkout_cart_dish_item.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  late OrderProvider orderProvider;
  final addressFormController = AddressFormController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    orderProvider = context.watch<OrderProvider>();
    final user = context.watch<UserProvider>().user;
    if (user != null) {
      addressFormController.setUser(user);
    }
  }

  void goBackToRestaurant() async {
    Navigator.of(context).popUntil((p) => p.settings.name == AppRoutes.dishes);
  }

  void placeOrder() {
    if (addressFormController.formKey.currentState!.validate()) {
      sendCreateOrderRequest();
    } else {
      print('Form is not valid!');
    }
  }

  void sendCreateOrderRequest() async {
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;
    final restaurant = ref.read(restaurantByIdProvider(restaurantId));
    final cart = ref.read(cartByRestaurantIdProvider(restaurantId));

    try {
      final user = addressFormController.getUser();
      final orderRequest = CreateOrderRequest(
        restaurant: restaurant,
        cartDishes: cart.cartDishes,
        user: user,
        createdAt: DateTime.now(),
      );
      await orderProvider.createOrder(orderRequest);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Order placed successfully!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong! Try again later!')),
        );
      }
    }
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
              isLoading: orderProvider.isCreating,
              child: Text('Place order'),
            ),
          ],
        ),
      ),
    );
  }
}

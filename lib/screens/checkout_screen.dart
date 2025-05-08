import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/data/restaurants_data.dart';
import 'package:plovo/helpers/request.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/order.dart';
import 'package:plovo/models/restaurant.dart';
import 'package:plovo/providers/cart_provider.dart';
import 'package:plovo/providers/user_provider.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/address_form/address_form.dart';
import 'package:plovo/widgets/address_form/address_form_controller.dart';
import 'package:plovo/widgets/checkout_card.dart';
import 'package:plovo/widgets/checkout_cart_dish_item.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Restaurant restaurant;
  late Cart cart;
  late CartProvider cartProvider;
  final addressFormController = AddressFormController();
  bool isOrderCreating = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;
    restaurant = restaurantsData.firstWhere((res) => res.id == restaurantId);
    cartProvider = context.watch<CartProvider>();
    cart = cartProvider.getCart(restaurantId);
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
    try {
      setState(() => isOrderCreating = true);
      final user = addressFormController.getUser();
      final orderRequest = CreateOrderRequest(
        restaurant: restaurant,
        cartDishes: cart.cartDishes,
        user: user,
        createdAt: DateTime.now(),
      );
      final url = '${dotenv.env['BASE_URL']}/orders.json';

      await request(url, method: 'POST', body: orderRequest.toJson());
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
    } finally {
      setState(() => isOrderCreating = false);
    }
  }

  @override
  void dispose() {
    addressFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              isLoading: isOrderCreating,
              child: Text('Place order'),
            ),
          ],
        ),
      ),
    );
  }
}

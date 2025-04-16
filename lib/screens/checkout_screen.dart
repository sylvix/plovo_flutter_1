import 'package:flutter/material.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/data/restaurants_data.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/restaurant.dart';
import 'package:plovo/models/route_arguments/cart_screen_arguments.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/checkout_card.dart';
import 'package:plovo/widgets/checkout_cart_dish_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Restaurant restaurant;
  late Cart cart;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)!.settings.arguments as CartScreenArguments;

    restaurant = restaurantsData.firstWhere(
      (res) => res.id == arguments.restaurantId,
    );
    cart = arguments.cart;
  }

  void goBackToRestaurant() async {
    Navigator.of(context).popUntil((p) => p.settings.name == AppRoutes.dishes);
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
                        Text('Your name'),
                        Text('Your street address'),
                        Text('Your phone number'),
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
            ActionButton(onPressed: () {}, child: Text('Place order')),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/data/restaurants_data.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/restaurant.dart';
import 'package:plovo/providers/cart_provider.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;
    restaurant = restaurantsData.firstWhere((res) => res.id == restaurantId);
    cartProvider = context.watch<CartProvider>();
    cart = cartProvider.getCart(restaurantId);
  }

  void goBackToRestaurant() async {
    Navigator.of(context).popUntil((p) => p.settings.name == AppRoutes.dishes);
  }

  void placeOrder() {
    if (addressFormController.formKey.currentState!.validate()) {
      final user = addressFormController.getUser();
      print(
        'Name: ${user.firstName} ${user.lastName}, address: ${user.address}',
      );
    } else {
      print('Form is not valid!');
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
                        AddressForm(controller: addressFormController),
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
            ActionButton(onPressed: placeOrder, child: Text('Place order')),
          ],
        ),
      ),
    );
  }
}

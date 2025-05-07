import 'package:flutter/material.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/screens/cart_screen.dart';
import 'package:plovo/screens/checkout_screen.dart';
import 'package:plovo/screens/dishes_screen.dart';
import 'package:plovo/screens/not_found_screen.dart';
import 'package:plovo/screens/profile_screen.dart';
import 'package:plovo/screens/restaurants_screen.dart';

typedef Routes = Map<String, Widget Function(BuildContext ctx)>;

class HomeNavigationScreen extends StatefulWidget {
  const HomeNavigationScreen({super.key});

  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  int selectedIndex = 0;

  final Routes homeRoutes = {
    AppRoutes.home: (ctx) => RestaurantsScreen(),
    AppRoutes.dishes: (ctx) => DishesScreen(),
    AppRoutes.cart: (ctx) => CartScreen(),
    AppRoutes.checkout: (ctx) => CheckoutScreen(),
  };

  final Routes profileRoutes = {AppRoutes.profile: (ctx) => ProfileScreen()};

  MaterialPageRoute onGenerateRoute(Routes routes, RouteSettings settings) {
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }
    return MaterialPageRoute(
      builder: (ctx) => NotFoundScreen(),
      settings: settings,
    );
  }

  void onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> get navigatorScreens => [
    Navigator(
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) => onGenerateRoute(homeRoutes, settings),
    ),
    Navigator(
      initialRoute: AppRoutes.profile,
      onGenerateRoute: (settings) => onGenerateRoute(profileRoutes, settings),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: navigatorScreens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

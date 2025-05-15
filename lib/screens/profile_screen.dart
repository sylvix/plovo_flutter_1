import 'package:flutter/material.dart';
import 'package:plovo/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void goToPersonalInformation(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.personalInformation);
  }

  void goToOrderHistory(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.orderHistory);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(title: Text('Profile'), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottomPadding + 60),
        child: Column(
          children: [
            ListTile(
              title: Text('Personal information'),
              leading: Icon(Icons.person),
              onTap: () => goToPersonalInformation(context),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text('Order history'),
              leading: Icon(Icons.history),
              onTap: () => goToOrderHistory(context),
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}

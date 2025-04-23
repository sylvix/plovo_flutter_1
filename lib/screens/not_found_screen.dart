import 'package:flutter/material.dart';
import 'package:plovo/widgets/center_placeholder.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  void goBackToHomeScreen(BuildContext context) {
    Navigator.of(context).popUntil((p) => p.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Not found')),
      body: CenterPlaceholder(
        title: 'This screen does not exist',
        iconData: Icons.disabled_by_default_outlined,
        buttonText: 'Go back to home screen',
        onButtonPressed: () => goBackToHomeScreen(context),
      ),
    );
  }
}

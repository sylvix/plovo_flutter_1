import 'package:flutter/material.dart';

class CheckoutCard extends StatelessWidget {
  final bool initiallyExpanded;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const CheckoutCard({
    super.key,
    this.initiallyExpanded = false,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return Card(
      elevation: 0,
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: shape,
          collapsedShape: shape,
          childrenPadding: EdgeInsets.symmetric(vertical: 16),
          initiallyExpanded: initiallyExpanded,
          title: Text(title, style: theme.textTheme.titleLarge),
          subtitle: Text(
            subtitle,
            style: theme.textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          children: children,
        ),
      ),
    );
  }
}

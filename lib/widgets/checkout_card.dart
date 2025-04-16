import 'package:flutter/material.dart';

class CheckoutCard extends StatelessWidget {
  final Widget? action;
  final bool initiallyExpanded;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const CheckoutCard({
    super.key,
    this.action,
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
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleLarge),
                    Text(
                      subtitle,
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (action != null) action!,
            ],
          ),
          children: children,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PxCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const PxCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

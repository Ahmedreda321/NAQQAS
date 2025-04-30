import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  const FAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'fab1',
          onPressed: () {},
          child: const Icon(Icons.add_rounded),
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          heroTag: 'fab2',
          onPressed: () {},
          child: const Icon(Icons.add_shopping_cart_rounded),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

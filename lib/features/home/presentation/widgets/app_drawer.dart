import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        const DrawerHeader(
          child: Text('Drawer Header'),
        ),
        ElevatedButton(
            onPressed: () {
              context.read<HomeCubit>().newSheet();
            },
            child: const Text('new Sheet')),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            // Handle item tap
          },
        ),
      ],
    ));
  }
}

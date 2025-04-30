import 'package:flutter/material.dart';
import 'package:naqqas/core/extensions/navigation_extensions.dart';

import '../cubit/home_state.dart';

class SearchWidget extends SearchDelegate<Medicine> {
  final List<Medicine> medicines;

  SearchWidget({required this.medicines});

  List<Medicine> _getSuggestions(String query) {
    return medicines
        .where((med) => med.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => context.back(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _getSuggestions(query);

    if (results.isEmpty) {
      return const Center(child: Text('No results found'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final med = results[index];
        return ListTile(
          title: Text(med.name),
          subtitle: Text('${med.dosage} • ${med.quantity} pcs'),
          onTap: () => close(context, med),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _getSuggestions(query);

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final med = suggestions[index];
        return ListTile(
          title: Text(med.name),
          onTap: () {
            query = med.name;
            showResults(context);
          },
        );
      },
    );
  }
}

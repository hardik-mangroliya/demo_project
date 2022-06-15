import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget>? buildAction(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget buildResult(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(
            fontSize: 50,
          ),
        ),
      );

  @override
  Widget buildSuggestion(BuildContext context) {
    List<String> suggestion = [
      'Abishek',
      'Neel',
      'Krutik',
      'Harsh',
    ];

    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (context, index) {
        // final suggestion = suggestion  [index];
        var suggestions;
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestions),
          onTap: () {
            query = suggestions;

            showResults(context);
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

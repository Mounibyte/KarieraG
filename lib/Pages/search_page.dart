
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class FormationSearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search formations';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Tap on a formation to view details.'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Stream<QuerySnapshot> formationsStream = FirebaseFirestore.instance
        .collectionGroup('mes_formations')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThan: query + 'z')
        .snapshots();

    return StreamBuilder(
      stream: formationsStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData ) {
          return Center(
            child: Text('No formations found.'),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['title']),
              onTap: () {
                // Handle formation selection here, e.g., navigate to formation details page
                Navigator.of(context).pop(data['title']); // Pass selected formation name back
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherchez ce qui vous convient',
        style: GoogleFonts.lora(fontSize: 14),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: FormationSearchDelegate());
            },
          ),
        ],
      ),
      body: Center(
        
      ),
    );
  }
}

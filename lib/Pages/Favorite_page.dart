import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late String _currentUserEmail;
  late List<DocumentSnapshot> _favoriteFormations;

  @override
  void initState() {
    super.initState();
    _favoriteFormations = [];
    _loadCurrentUserEmail();
  }

  Future<void> _loadCurrentUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUserEmail = user.email!;
      });
      _loadFavoriteFormations();
    }
  }

  Future<void> _loadFavoriteFormations() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('favoris')
        .doc(_currentUserEmail)
        .collection('mes_favoris')
        .get();
    setState(() {
      _favoriteFormations = querySnapshot.docs;
    });
  }

  Future<void> _toggleFavorite(DocumentSnapshot formation, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    final formationId = formation.id;
    setState(() {
      if (isFavorite) {
        _favoriteFormations.remove(formation);
        prefs.setBool(formationId, false);
      } else {
        _favoriteFormations.add(formation);
        prefs.setBool(formationId, true);
      }
    });

    if (_currentUserEmail.isNotEmpty) {
      final docRef = FirebaseFirestore.instance
          .collection('favoris')
          .doc(_currentUserEmail)
          .collection('mes_favoris')
          .doc(formationId);
      if (isFavorite) {
        await docRef.delete();
      } else {
        await docRef.set(formation.data() as Map<String, dynamic>);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formations favorites'),
      ),
      body: ListView.builder(
        itemCount: _favoriteFormations.length,
        itemBuilder: (context, index) {
          final formation = _favoriteFormations[index];
          final isFavorite = true; // Mettez ici la logique pour vérifier si la formation est en favori ou non
          return ListTile(
            title: Text(formation['title'] ?? ''),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () => _toggleFavorite(formation, isFavorite),
            ),
          );
        },
      ),
    );
  }
}

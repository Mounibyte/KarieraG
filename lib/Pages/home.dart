import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Kariera/Pages/formulaire_aremplir.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
    getCurrentUserEmail();
  }

  void getCurrentUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserEmail = user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formations'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Formations disponibles',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collectionGroup('mes_formations').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text('Une erreur s\'est produite');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var formation = snapshot.data!.docs[index];
                    return FormationListItem(
                      formation: formation,
                      currentUserEmail: currentUserEmail,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FormationListItem extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> formation;
  final String? currentUserEmail;

  const FormationListItem({Key? key, required this.formation, required this.currentUserEmail}) : super(key: key);

  @override
  _FormationListItemState createState() => _FormationListItemState();
}

class _FormationListItemState extends State<FormationListItem> {
  bool _showDetails = false;
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
    _isFavorite = false; // Initialise _isFavorite ici
  }

  Future<void> _loadFavoriteState() async {
    final prefs = await SharedPreferences.getInstance();
    final isFavorite = prefs.getBool('${widget.formation.id}-${widget.currentUserEmail}') ?? false;
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.formation.id}-${widget.currentUserEmail}', _isFavorite);
    if (_isFavorite) {
      // Ajouter la formation aux favoris
      if (widget.currentUserEmail != null) {
        FirebaseFirestore.instance.collection('favoris').doc(widget.currentUserEmail).collection('mes_favoris').doc(widget.formation.id).set(widget.formation.data() as Map<String, dynamic>);
      }
    } else {
      // Supprimer la formation des favoris
      if (widget.currentUserEmail != null) {
        FirebaseFirestore.instance.collection('favoris').doc(widget.currentUserEmail).collection('mes_favoris').doc(widget.formation.id).delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDetails = !_showDetails;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.formation['imageUrl'] ?? '',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.formation['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.attach_money),
                      Text(
                        widget.formation['prix'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: _isFavorite ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                  if (_showDetails) ...[
                    const SizedBox(height: 10),
                    Text(
                      'About: ${widget.formation['about']}',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Durée: ${widget.formation['duree']}',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Prérequis: ${widget.formation['prerequis']}',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Catégorie: ${widget.formation['categorie']}',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormulaireEtudiant(formationTitle: widget.formation['title']),
                          ),
                        );
                      },
                      child: const Text('S\'inscrire'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

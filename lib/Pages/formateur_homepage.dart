import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Kariera/Pages/addformation.dart';

class FormateurHomepage extends StatefulWidget {
  const FormateurHomepage({Key? key}) : super(key: key);

  @override
  State<FormateurHomepage> createState() => _FormateurHomepageState();
}

class _FormateurHomepageState extends State<FormateurHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'welcomepage', (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Vos Formations',
                style: GoogleFonts.notoSerif(
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('formations')
                  .doc(FirebaseAuth.instance.currentUser?.email)
                  .collection('mes_formations')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('Aucune formation trouvée.'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var formation = snapshot.data!.docs[index];
                    return FormationListItem(
                      formation: formation,
                      onDelete: () async {
                        if (FirebaseAuth.instance.currentUser != null) {
                          await FirebaseFirestore.instance
                              .collection('formations')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection('mes_formations')
                              .doc(formation.id)
                              .delete();
                        }
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[200],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddFormation()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormationListItem extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> formation;
  final Function onDelete;

  const FormationListItem({
    Key? key,
    required this.formation,
    required this.onDelete,
  }) : super(key: key);

  @override
  _FormationListItemState createState() => _FormationListItemState();
}

class _FormationListItemState extends State<FormationListItem> {
  bool _tban = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tban = !_tban;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.formation['title'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.onDelete();
                  },
                ),
              ],
            ),
            Image.network(
              widget.formation['imageUrl'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            if (_tban)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Titre: ${widget.formation['title']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('About: ${widget.formation['about']}'),
                    const SizedBox(height: 10),
                    Text('Prix: ${widget.formation['prix']}'),
                    const SizedBox(height: 10),
                    Text('Durée: ${widget.formation['duree']}'),
                    const SizedBox(height: 10),
                    Text('Prérequis: ${widget.formation['prerequis']}'),
                    const SizedBox(height: 10),
                    Text('Catégorie: ${widget.formation['categorie']}'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

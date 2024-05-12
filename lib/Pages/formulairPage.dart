import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FormulairPage extends StatefulWidget {
  const FormulairPage({Key? key}) : super(key: key);

  @override
  _FormulairPageState createState() => _FormulairPageState();
}

class _FormulairPageState extends State<FormulairPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _formulaireDataList = [];

  @override
  void initState() {
    super.initState();
    _fetchFormulaireData();
  }

  Future<void> _fetchFormulaireData() async {
    // Récupérer l'e-mail de l'utilisateur actuellement connecté
    User? user = _auth.currentUser;
    String? formateurEmail = user != null ? user.email : null;

    // Vérifier si l'utilisateur est connecté
    if (formateurEmail != null) {
      // Récupérer tous les formulaires de l'utilisateur connecté
      QuerySnapshot formulairesSnapshot = await _firestore
          .collection('formulaires')
          .doc(formateurEmail)
          .collection('mes_formulaires')
          .get();

      // Pour chaque formulaire, récupérer les détails et lier à une formation
      await Future.forEach(formulairesSnapshot.docs, (formulaireDoc) async {
        Map<String, dynamic> formulaireData =
            formulaireDoc.data() as Map<String, dynamic>;
        String formationTitle = formulaireData['formationTitle'];

        QuerySnapshot formationSnapshot = await _firestore
            .collection('formations')
            .where('title', isEqualTo: formationTitle)
            .get();

        if (formationSnapshot.docs.isNotEmpty) {
          // Extraire les détails de la formation
          Map<String, dynamic> formationData =
              formationSnapshot.docs.first.data() as Map<String, dynamic>;

          // Vérifier si le titre de la formation correspond au titre du formulaire
          if (formationData['title'] == formationTitle) {
            setState(() {
              _formulaireDataList.add(formulaireData);
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails des formulaires'),
      ),
      body: _formulaireDataList.isEmpty
          ? const Center(child: const CircularProgressIndicator())
          : ListView.builder(
              itemCount: _formulaireDataList.length,
              itemBuilder: (context, index) {
                final formulaireData = _formulaireDataList[index];
                return ListTile(
                  title: Text('Formation: ${formulaireData['formationTitle']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom: ${formulaireData['nom']}'),
                      Text('Email: ${formulaireData['email']}'),
                      Text('Niveau: ${formulaireData['niveau']}'),
                      Text('Compétences: ${formulaireData['competences']}'),
                      Text('Numéro: ${formulaireData['numero']}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class FormulaireEtudiant extends StatefulWidget {
  final String formationTitle; // Ajout du titre de la formation
  const FormulaireEtudiant({Key? key, required this.formationTitle}) : super(key: key);

  @override
  _FormulaireEtudiantState createState() => _FormulaireEtudiantState();
}

class _FormulaireEtudiantState extends State<FormulaireEtudiant> {
  final TextEditingController nomEtPrenomController = TextEditingController();
  final TextEditingController niveauController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController competencesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pré-remplir le champ Email avec l'email de l'utilisateur
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      emailController.text = currentUser.email ?? '';
    }
  }

  Future<void> _sendInfo() async {
    try {
      final formulaireCollection = FirebaseFirestore.instance.collection('formulaires');
      final userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userEmail != null) {
        final userDocumentRef = formulaireCollection.doc(userEmail);
        final formData = {
          'nom': nomEtPrenomController.text,
          'niveau': niveauController.text,
          'email': emailController.text,
          'numero': numeroController.text,
          'competences': competencesController.text,
          'formationTitle': widget.formationTitle, // Ajout du titre de la formation
        };

        // Stocker les détails du formulaire dans la sous-collection 'mes_formulaires'
        await userDocumentRef.collection('mes_formulaires').add(formData);

        // Efface les champs après l'envoi du formulaire
        nomEtPrenomController.clear();
        niveauController.clear();
        numeroController.clear();
        competencesController.clear();

        // Retour à l'écran précédent
        Navigator.pop(context);
      } else {
        print('Utilisateur non connecté');
      }
    } catch (e) {
      print('Erreur lors de l\'envoi du formulaire: $e');
      // Gérer les erreurs d'envoi de formulaire
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remplir le formulaire'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Formation: ${widget.formationTitle}', // Affichage du titre de la formation
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: nomEtPrenomController,
                decoration: const InputDecoration(labelText: 'Nom et Prénom'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: niveauController,
                decoration: const InputDecoration(labelText: 'Niveau'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                enabled: true, // Permettre à l'utilisateur de modifier l'email
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: numeroController,
                decoration: const InputDecoration(labelText: 'Numéro de téléphone'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: competencesController,
                decoration: const InputDecoration(labelText: 'Compétences'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _sendInfo,
                child: const Text('Envoyer le formulaire'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

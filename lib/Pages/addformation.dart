import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFormation extends StatefulWidget {
  const AddFormation({Key? key}) : super(key: key);

  @override
  _AddFormationState createState() => _AddFormationState();
}

class _AddFormationState extends State<AddFormation> {
  final TextEditingController formationTitleController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController dureeController = TextEditingController();
  final TextEditingController prerequisController = TextEditingController();
  final TextEditingController nomInstitutController = TextEditingController();
  final TextEditingController categorieController = TextEditingController(); // Nouveau contrôleur pour la catégorie
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final formateur = FirebaseAuth.instance.currentUser;

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _sendFormationData() async {
    try {
      final formationCollection = FirebaseFirestore.instance.collection('formations');
      final userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userEmail != null) {
        final userDocumentRef = formationCollection.doc(userEmail);
        final imageRef = FirebaseStorage.instance.ref().child('FormationsImages').child('${DateTime.now()}.jpg');

        // Upload de l'image
        if (_image != null) {
          await imageRef.putFile(_image!);
          final imageUrl = await imageRef.getDownloadURL();

          // Ajout des données de la formation dans Firestore
          await userDocumentRef.collection('mes_formations').add({
            'title': formationTitleController.text,
            'prix': prixController.text,
            'about': aboutController.text,
            'duree': dureeController.text,
            'prerequis': prerequisController.text,
            'nomInstitut': nomInstitutController.text,
            'categorie': categorieController.text, // Ajout de la catégorie
            'imageUrl': imageUrl, // Ajout de l'URL de l'image
          });

          formationTitleController.clear();
          prixController.clear();
          aboutController.clear();
          dureeController.clear();
          prerequisController.clear();
          nomInstitutController.clear();
          categorieController.clear(); // Effacer le champ de la catégorie
          setState(() {
            _image = null;
          });

          Navigator.pop(context);
        } else {
          // Gérer l'absence d'image
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erreur'),
                content: const Text('Veuillez sélectionner une image.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        print('Utilisateur non connecté');
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de la formation: $e');
      // Gérer les erreurs d'ajout de formation
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une formation'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: _getImage,
                child: _image == null
                    ? const Icon(Icons.add_a_photo, size: 100.0)
                    : Image.file(_image!, width: 100.0, height: 100.0),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: formationTitleController,
                decoration: const InputDecoration(labelText: 'Titre de la formation'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: prixController,
                decoration: const InputDecoration(labelText: 'Prix'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: aboutController,
                decoration: const InputDecoration(labelText: 'À propos'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: dureeController,
                decoration: const InputDecoration(labelText: 'Durée'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: prerequisController,
                decoration: const InputDecoration(labelText: 'Prérequis'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: nomInstitutController,
                decoration: const InputDecoration(labelText: 'Nom de l\'institut'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: categorieController,
                decoration: const InputDecoration(labelText: 'Catégorie'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _sendFormationData,
                child: const Text('Ajouter cette formation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

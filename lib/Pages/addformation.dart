import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Kariera/Components/textfield.dart';

class AddFormation extends StatefulWidget {
  const AddFormation({super.key});

  @override
  State<AddFormation> createState() => _AddFormationState();
}

class _AddFormationState extends State<AddFormation> {
  final formationtitleController = TextEditingController();
  final prixController = TextEditingController();
  final aboutController = TextEditingController();
  final dureeController = TextEditingController();
  final prerequisController = TextEditingController();
  final formateur = FirebaseAuth.instance.currentUser;
  void _sendformationdata() async {
    await FirebaseFirestore.instance
        .collection('formation')
        .doc(formateur?.email)
        .set({
      'title': formationtitleController.text,
      'prix': prixController.text,
      'about': aboutController.text,
      'prerequis': prerequisController.text,
    });
    formationtitleController.clear();
    prixController.clear();
    aboutController.clear();
    prerequisController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              textfield(
                hintText: 'formation title',
                obscureText: false,
                controlleer: formationtitleController,
              ),
              SizedBox(
                height: 20,
              ),
              textfield(
                hintText: 'Prix formation',
                obscureText: false,
                controlleer: prixController,
              ),
              SizedBox(
                height: 20,
              ),
              textfield(
                hintText: 'about formation',
                obscureText: false,
                controlleer: aboutController,
              ),
              SizedBox(
                height: 20,
              ),
              textfield(
                hintText: 'duree formation',
                obscureText: false,
                controlleer: dureeController,
              ),
              SizedBox(
                height: 20,
              ),
              textfield(
                hintText: 'Preruquis',
                obscureText: false,
                controlleer: prerequisController,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _sendformationdata();

                  //func li dkhl li donner fel firebase + n3yto lel collection li tl3houh f homa pagr ta3 etudient
                },
                child: Text('add this formation'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

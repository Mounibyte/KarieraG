import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Kariera/Components/formation_tile.dart';
import 'package:Kariera/Pages/Homepage.dart';
import 'package:provider/provider.dart';
import 'package:Kariera/Models/Formations_model.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _username = FirebaseFirestore.instance.collection('users').doc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 229, 80, 255),
        title: Text('Udemy'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Bienvenue, furry',
                  style: GoogleFonts.lora(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Advancing Android Developer',
                  style: GoogleFonts.lora(fontSize: 13, color: Colors.black54),
                ),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Modifier l'objectif",
                      style: GoogleFonts.lora(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    )),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 250,
                  width: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/woman2.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Un apprentissage adapté",
                  style: GoogleFonts.notoSerif(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Vous avez un reve ? Commencez a apprendre et exaucez-le avec nos cours',
                  style: GoogleFonts.lora(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        'Selection',
                        style: GoogleFonts.notoSerif(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 450,
                  width: 500,
                  child: Consumer<FormationModel>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(12),
                        itemCount:
                            Provider.of<FormationModel>(context, listen: false)
                                .formations
                                .length, // Access the list using the 'context'
                        itemBuilder: (context, index) {
                          final formationsModel = Provider.of<FormationModel>(
                              context,
                              listen: false); // Get the Cart_Model instance
                          return FormationTile(
                            Nomformations: formationsModel.formations[index][0],
                            NomInstitut: formationsModel.formations[index][1],
                            formationimg: formationsModel.formations[index][2],
                            Rating: formationsModel.formations[index][3],
                            onPressed: () {},
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

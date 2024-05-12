import 'package:Kariera/Pages/formateur_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Kariera/Pages/Homepage.dart';
import 'package:Kariera/Pages/Settings.dart';

class FormateurProfile extends StatelessWidget {
  FormateurProfile({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;

  final userCollection = FirebaseFirestore.instance.collection('formateurs');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return formateurhome();
                },
              ));
            },
            icon: const Icon(Icons.keyboard_arrow_left_sharp)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Setting();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('formateurs')
                .where('email', isEqualTo: currentUser.email)
                .limit(1)
                .snapshots(),
            builder: (context, snapshot) {
              print(currentUser);
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                var userData = snapshot.data!.docs[0];
                String numero = userData['numero'];
                String email = userData['email'];
                String nom_dinstitut = userData['nom_dinstitut'];
                return SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/wondering.jpg'),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 5),
                                    color: Colors.white,
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  )
                                ]),
                            child: ListTile(
                              title: const Text('E-mail'),
                              subtitle: Text(email),
                              leading: const Icon(Icons.mail),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_forward)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 5),
                                    color: Colors.white,
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  )
                                ]),
                            child: ListTile(
                              title: const Text('Numero de telephone'),
                              subtitle: Text(numero),
                              leading: const Icon(Icons.phone),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_forward)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 5),
                                    color: Colors.white,
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  )
                                ]),
                            child: ListTile(
                              title: const Text("Nom d'institut"),
                              subtitle: Text(nom_dinstitut),
                              leading: const Icon(Icons.school),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_forward)),
                            ),
                          ),
                        ),
                       
                        const SizedBox(
                          height: 35,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();

                            Navigator.pushNamedAndRemoveUntil(
                                context, 'welcomepage', (route) => false);
                          },
                          child: Text(
                            "Se déconnecter",
                            style: GoogleFonts.lora(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error ${snapshot.error}'),
                );
              }
              return const Center(child: Text('No data'));
            }),
      ),
    ));
  }
}


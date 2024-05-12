import 'package:flutter/material.dart';
import 'package:Kariera/Pages/Formateur.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 244, 241, 241), // Fond blanc
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Center(
                        child: Text(
                                          "Bienvenue a Kariera",
                                          style: GoogleFonts.notoSerif(
                          fontSize: 30, ),
                                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                     Center(
                       child: Text(
                        "Choisissez votre espace",
                        style: GoogleFonts.lora(
                            fontSize: 20,
                      
                            color: Colors.black87),
                                           ),
                     ),
                    const SizedBox(
                      height: 100,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        child: const Image(
                          image: AssetImage('assets/student.png'),
                          width: 100,
                        ),
                      ),
                    ),
                    Text(
                      "Etudiant",
                      style: GoogleFonts.lora(
                          fontSize: 18,
                          
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    InkWell(
                      onTap: () {
                        //tedina l page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FormateurPage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        ),
                        child:  const Image(
                          
                          image: AssetImage('assets/formateur.png'),
                          width: 100,
                        ),
                      ),
                    ),
                    Text(
                      "Formateur",
                      style: GoogleFonts.lora(
                          fontSize: 18,
                          
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

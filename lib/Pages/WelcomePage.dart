import 'package:flutter/material.dart';
import 'package:Kariera/Pages/Formateur.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color:  Color.fromARGB(255, 47, 94, 168), // Fond bleu
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
                    const Text(
                      "Welcome In Kariera",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xff00a1e2), // Texte bleu ciel
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Some Stupid desc gdboo,ddlmvpspvkiifkvvvvvvvvvvvvvvvv",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff00a1e2),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: const Image(
                        image: AssetImage('assets/etudiant.png'),
                        width: 100,
                      ),
                    ),
                    const Text(
                      'Etudiant',
                      style: TextStyle(fontSize: 20, color: Color(0xff00a1e2),),
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
                      child: const Image(
                        image: AssetImage('assets/formateur.png'),
                        width: 100,
                      ),
                    ),
                    const Text(
                      'Formateur',
                      style: TextStyle(fontSize: 20, color: Color(0xff00a1e2),),
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

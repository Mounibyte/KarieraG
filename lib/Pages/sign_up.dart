import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Kariera/Components/helper_function.dart';
import 'package:Kariera/Components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController Emailcontroller = TextEditingController();
  final TextEditingController Usernamecontroller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController();
  final TextEditingController confirmpwcontroller = TextEditingController();
  bool isLoading = false; // Ajout d'un indicateur de chargement

  Future<void> signup() async {
    setState(() {
      isLoading = true; // Activer l'indicateur de chargement au début du processus d'inscription
    });

    if (pwcontroller.text != confirmpwcontroller.text) {
      displayMessageToUser("Passwords doesn't match", context);
      setState(() {
        isLoading = false; // Désactiver l'indicateur de chargement en cas d'erreur
      });
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: Emailcontroller.text, password: pwcontroller.text);
      _sendInfo(Emailcontroller.text, pwcontroller.text);
      Navigator.pushReplacementNamed(context, "homepage");
    } on FirebaseAuthException catch (e) {
      displayMessageToUser(e.code, context);
    } finally {
      setState(() {
        isLoading = false; // Désactiver l'indicateur de chargement à la fin du processus d'inscription
      });
    }
  }

 


//rani zdt hdi func bach dkhl data f firestore
  void _sendInfo(String email, String password) async {
    if (Usernamecontroller.text.trim().isEmpty) return;

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Use email from Emailcontroller.text instead of currentUser.email
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'username': Usernamecontroller.text,
        'password': password,
        'userId': currentUser.uid,
        'email': email, // Use email from Emailcontroller.text
      });
    }
  }
// tkml hna w rani m3ytllha f button win kyn sign_up

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Icon(
              Icons.app_registration_rounded,
              size: 100,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Fill this below',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            textfield(
                hintText: 'Email',
                obscureText: false,
                controlleer: Emailcontroller),
            const SizedBox(
              height: 20,
            ),
            textfield(
                hintText: 'Username',
                obscureText: false,
                controlleer: Usernamecontroller),
            const SizedBox(
              height: 20,
            ),
            textfield(
                hintText: 'Password',
                obscureText: true,
                controlleer: pwcontroller),
            const SizedBox(
              height: 20,
            ),
            textfield(
                hintText: 'Confirm Password',
                obscureText: true,
                controlleer: confirmpwcontroller),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                signup();
                _sendInfo(Emailcontroller.text, pwcontroller.text);
                Navigator.pushReplacementNamed(context, "homepage");
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 35),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                    child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have An account !"),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "login");
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            )
          ],
        )),
      ),
    );
  }
}

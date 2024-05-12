import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormateurPage extends StatefulWidget {
  const FormateurPage({Key? key}) : super(key: key);

  @override
  State<FormateurPage> createState() => _FormateurPageState();
}

class _FormateurPageState extends State<FormateurPage> {
  final emailController = TextEditingController();
  final _emailController = TextEditingController();
  final letterController = TextEditingController();

  bool _here = false;

  void _check_info_formateur() async {
    if (_emailController.text.trim().isEmpty) return;

    final documentSnapshot = await FirebaseFirestore.instance
        .collection('ourformateurs')
        .doc(_emailController.text)
        .get();
    if (documentSnapshot.exists) {
      final email = documentSnapshot['newEmail'];

      print(email);
      if (_emailController.text == email) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: "000000");
        _emailController.clear();
        Navigator.pushReplacementNamed(context, "formateurhome");
      } else {
        AwesomeDialog(
                context: context,
                title: 'info',
                dialogType: DialogType.info,
                animType: AnimType.leftSlide,
                desc: 'You Are Not accepted Yet')
            .show();
      }
      //Navigat to add button(formation page) and my formation
    } else {
      AwesomeDialog(
              context: context,
              title: 'error',
              dialogType: DialogType.error,
              animType: AnimType.leftSlide,
              desc: 'there is a problem please try again')
          .show();
    }
  }

  void _sendinfo_formateur() async {
    if (emailController.text.trim().isEmpty &&
        letterController.text.trim().isEmpty) return;
    await FirebaseFirestore.instance
        .collection('formateurs')
        .doc(emailController.text)
        .set({
      'email': emailController.text, //gmail.com

      'letter': letterController.text,
    });
    emailController.clear();
    letterController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        "Login as Formateur",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 150,
                          child: Image(image: AssetImage('assets/frm2.jpg'))),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Your Email Ends with udemylite.com',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey)),
                          onPressed: () {
                            _check_info_formateur();
                          },
                          child: Text(
                            'login',
                            style: TextStyle(color: Colors.black),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Be a formateur with us!'),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _here = !_here;
                              });
                            },
                            child: const Text('here'),
                          ),
                        ],
                      ),
                      
                      _here
                          ? Column(
                              children: [
                                const Text(
                                  'file this please we will Contact you',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 186, 3, 3),
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Email Personal',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: letterController,
                                  decoration: InputDecoration(
                                    hintText: 'Registration Letter',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.grey)),
                                    onPressed: () {
                                      //sned info to firestore fourmateur_demande
                                      _sendinfo_formateur();
                      
                                      AwesomeDialog(
                                              context: context,
                                              title: 'All Good',
                                              dialogType: DialogType.success,
                                              animType: AnimType.leftSlide,
                                              desc:
                                                  'Check your Email we send you a new email to sign in')
                                          .show();
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                            )
                          : SizedBox(), // If not _here, display an empty SizedBox
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

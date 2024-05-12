import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
       
      ),
      body: Center(
        child:  GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();

                            Navigator.pushNamedAndRemoveUntil(
                                context, 'login', (route) => false);
                          },
                          child: Text(
                            "Se déconnecter",
                            style: GoogleFonts.lora(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
      ),
    );
  }
}

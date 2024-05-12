import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:Kariera/Pages/addformation.dart';
import 'package:Kariera/Pages/formulairPage.dart';
import 'package:Kariera/Pages/formateurprofile.dart';

class formateurhome extends StatefulWidget {
  const formateurhome({super.key});

  @override
  State<formateurhome> createState() => _formateurhomeState();
}

class _formateurhomeState extends State<formateurhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
                      'Formateur page',
                      style: TextStyle(fontSize: 20, color: Color(0xff00a1e2),),
                    ),
        backgroundColor: const Color(0xff0f2240),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'welcomepage', (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Text(
            'Home Page Formation No DATA!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddFormation()));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: GNav(
        backgroundColor: const Color(0xff0f2240),
        color: const Color(0xff00a1e2),
        activeColor: const Color(0xff00a1e2),
        gap: 8,
        curve: Curves.easeOutExpo,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
              Navigator.pushNamed(context, 'formateurhome');
            },
          ),
          GButton(
            icon: Icons.format_align_center_outlined,
            text: 'forma',
            onPressed: () {
              Navigator.pushNamed(context, 'formulair');
            },
          ),
          GButton(
            icon: Icons.person_outlined,
            text: 'Profile',
            onPressed: () {
              Navigator.pushNamed(context, 'formateurprofile');
            },
          ),
        ],
      ),
    );
  }
}

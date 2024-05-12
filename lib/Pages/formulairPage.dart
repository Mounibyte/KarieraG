import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class FormulairPage extends StatefulWidget {
  const FormulairPage({super.key});

  @override
  State<FormulairPage> createState() => _FormulairPageState();
}

class _FormulairPageState extends State<FormulairPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
                      'Formulair page',
                      style: TextStyle(fontSize: 20, color: Color(0xff00a1e2),),
                    ),
        backgroundColor: const Color(0xff0f2240),
      ),
      body: Container(), //ychof les formulair etudiant
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

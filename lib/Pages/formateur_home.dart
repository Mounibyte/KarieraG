import 'package:Kariera/Pages/formateurProfile.dart';
import 'package:Kariera/Pages/formateur_homepage.dart';
import 'package:Kariera/Pages/formulairPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class formateurhome extends StatefulWidget {
  formateurhome({super.key});

  @override
  State<formateurhome> createState() => _formateurhomeState();
}

class _formateurhomeState extends State<formateurhome> {
int _selectedIndex = 0;
void Navigate(int index){
setState(() {
  _selectedIndex=index;
});
}
final List <Widget>_pages = [
 FormateurHomepage(),
 FormulairPage(),
 FormateurProfile(),
];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    
      bottomNavigationBar:GNav(
        backgroundColor: Colors.transparent,
        activeColor: Colors.grey[800],
onTabChange: (index) => Navigate(index),
        tabs: [
        
        const GButton(icon: Icons.home,
        text: "Home",
        ),
         const GButton(icon: Icons.format_align_center_outlined,
        text: "Formulaires",
        ),
         const GButton(icon: Icons.person,
        text: "Profile",
        ),
      ],),
      body: _pages[_selectedIndex] ,
      );
  }
}
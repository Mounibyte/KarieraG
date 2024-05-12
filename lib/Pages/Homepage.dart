import 'package:Kariera/Pages/Favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:Kariera/Pages/home.dart';
import 'package:Kariera/Pages/profile_page.dart';
import 'package:Kariera/Pages/search_page.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
int _selectedIndex = 0;
void Navigate(int index){
setState(() {
  _selectedIndex=index;
});
}
final List <Widget>_pages = [
HomePage(),
SearchPage(),
FavoritePage(),
ProfilePage(),
];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    
      bottomNavigationBar:GNav(
        backgroundColor: Colors.transparent,
        activeColor: Colors.grey[800],
onTabChange: (index) => Navigate(index),
        tabs: [
        
        GButton(icon: Icons.home,
        text: "Home",
        ),
         GButton(icon: Icons.search,
        text: "Search",
        ),
         GButton(icon: Icons.favorite,
        text: "Favorite",
        ),
         GButton(icon: Icons.person,
        text: "Profile",
        ),
      ],),
      body: _pages[_selectedIndex] ,
      );
  }
}
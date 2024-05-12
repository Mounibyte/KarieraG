

import 'package:Kariera/Pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Objectifpage extends StatelessWidget {
  const Objectifpage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => Homepage(),));
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
      children: [
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal :15.0),
        child: Container(
          
                  constraints: BoxConstraints(maxWidth: 350.0),
                   child: Text("Pour quelle profession souhaitez-vous acquérir de nouvelles compétences ?",style: GoogleFonts.notoSerif(fontSize: 18,fontWeight: FontWeight.bold),),
        ),
      ),
      SizedBox(height: 20,),
      
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Container(child: Text('Sélectionnée : Android Developer',style: GoogleFonts.lora(fontSize: 16,color: Colors.black54),)),
          
          ),
          SizedBox(height: 25,),
          Text("Domaines populaires",style: GoogleFonts.notoSerif(fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 25,),
          ListTile(
          title: Text('Développement de logiciels'),
          titleTextStyle: GoogleFonts.lora(fontSize: 16,color: Colors.black),
          trailing: IconButton(onPressed: () {
            
          }, icon: Icon(Icons.arrow_forward)),),
           ListTile(
          title: Text('Données et analyses'),
          titleTextStyle: GoogleFonts.lora(fontSize: 16,color: Colors.black),
          trailing: IconButton(onPressed: () {
            
          }, icon: Icon(Icons.arrow_forward)),),
           ListTile(
          title: Text("Technologies de l'information"),
          titleTextStyle: GoogleFonts.lora(fontSize: 16,color: Colors.black),
          trailing: IconButton(onPressed: () {
            
          }, icon: Icon(Icons.arrow_forward)),),
           ListTile(
          title: Text('Marketing'),
          titleTextStyle: GoogleFonts.lora(fontSize: 16,color: Colors.black),
          trailing: IconButton(onPressed: () {
            
          }, icon: Icon(Icons.arrow_forward)),),
           ListTile(
          title: Text('Design'),
          titleTextStyle: GoogleFonts.lora(fontSize: 16,color: Colors.black),
          trailing: IconButton(onPressed: () {
            
          }, icon: Icon(Icons.arrow_forward)),),
           ListTile(
          title: Text('Finance et comptabilité'),
          titleTextStyle: GoogleFonts.lora(fontSize: 16,color: Colors.black),
          trailing: IconButton(onPressed: () {
            
          }, icon: Icon(Icons.arrow_forward)),),
        
        ],
      ),
    );
  }
}
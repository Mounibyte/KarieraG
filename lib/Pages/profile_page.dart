import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:Kariera/Pages/Homepage.dart';
import 'package:Kariera/Pages/Settings.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser; // Change currentUser to be nullable

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser; // Assign currentUser
  }

  void _editProfile() {
    // Implement navigation to the edit profile screen or dialog
    // Example:
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 238, 238, 238),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Homepage();
                },
              ));
            },
            icon: const Icon(Icons.keyboard_arrow_left_sharp),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Setting();
                    },
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _editProfile,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: currentUser?.email)
                .limit(1)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                var userData = snapshot.data!.docs[0];
                String username = userData['username'];
                String email = userData['email'];
                String password = userData['password'];
                return SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/wondering.jpg'),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.white,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: ListTile(
                              title: const Text('Nom'),
                              subtitle: Text(username),
                              leading: const Icon(Icons.person),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.white,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: ListTile(
                              title: const Text('E-mail'),
                              subtitle: Text(email),
                              leading: const Icon(Icons.mail),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.white,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: ListTile(
                              title: const Text('Password'),
                              subtitle: Text(password),
                              leading: const Icon(Icons.lock),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.white,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: const ListTile(
                              title: Text('Objectif'),
                              subtitle:
                                  Text('Advanced Android Developer'),
                              leading: Icon(Icons.person_pin),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        GestureDetector(
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
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error ${snapshot.error}'),
                );
              }
              return const Center(child: Text('No data'));
            },
          ),
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  @override
void initState() {
  super.initState();
  // Initialize text controllers with current user data if available
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    _usernameController.text = currentUser.displayName ?? '';
    _emailController.text = currentUser.email ?? '';
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.white,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: ' New nom',
                  labelStyle:  
                             GoogleFonts.lora(
                              fontSize: 16,
                              
                              color: Colors.black,
                            ),
              ),
            ),
            ),
             ),
            const SizedBox(height: 20,),
             Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.white,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'E-mail',
                  labelStyle: GoogleFonts.lora(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                  ),
              ),
                          ),
            ),
            const SizedBox(height: 20,),
             Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.white,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
              child: TextFormField(
                showCursor: false,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'New Password',
                  labelStyle: GoogleFonts.lora(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                  ),
              ),
                          ),
            ),
            const SizedBox(height: 20,),
           Center(
             child: TextButton(
               onPressed: () async {
                 try {
                   // Get current user
                   User? user = FirebaseAuth.instance.currentUser;
             
                   // Update user profile with new data
                   await user?.updateDisplayName(_usernameController.text);
                   await user?.updateEmail(_emailController.text);
             
                   // If password is changed, update it separately
                   if (_passwordController.text.isNotEmpty) {
                     await user?.updatePassword(_passwordController.text);
                   }
             
                   // Update user data in Firestore if needed
                   await FirebaseFirestore.instance
                       .collection('users')
                       .doc(user?.uid)
                       .update({
                     'username': _usernameController.text,
                     'email': _emailController.text,
                     // Update other profile fields here
                   });
             
                   // Show success message or navigate back to profile page
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(
                       content: Text('Profile updated successfully'),
                     ),
                   );
                   Navigator.pop(context); // Navigate back to profile page
                 } catch (error) {
                   // Show error message if profile update fails
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: Text('Failed to update profile: $error'),
                     ),
                   );
                 }
               },
               child: Text(
                            "Enregister",
                            style: GoogleFonts.lora(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),)
             ),
           ),
          
             
          ],
        ),
      ),
    );
  }
}

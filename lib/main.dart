import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Kariera/Models/Formations_model.dart';
import 'package:Kariera/Pages/Favorite_page.dart';
import 'package:Kariera/Pages/Homepage.dart';
import 'package:Kariera/Pages/WelcomePage.dart';
import 'package:Kariera/Pages/formateurProfile.dart';
import 'package:Kariera/Pages/formateur_home.dart';
import 'package:Kariera/Pages/formulairPage.dart';
import 'package:Kariera/Pages/intro2.dart';
import 'package:Kariera/Pages/profile_page.dart';
import 'package:Kariera/Pages/sign_up.dart';
import 'package:Kariera/firebase_options.dart';
import 'package:Kariera/Pages/login_page.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => FormationModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('==============User is currently signed out!');
      } else {
        print('====================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kariera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:
          FirebaseAuth.instance.currentUser == null ? Intropage2() : formateurhome(),
      routes: {
        "homepage": (context) => Homepage(),
        "profil": (context) => ProfilePage(),
        "fav": (context) => FavoritePage(),
        "signup": (context) => Signup(),
        "login": (context) => Loginpage(),
        "formateurhome": (context) => formateurhome(),
        "welcomepage": (context) => WelcomePage(),
        "formulair": (context) =>
            FormulairPage(), //hdi tetbdl men ba3d 3la hsab page t3 yassin
        "formateurprofile": (context) => FormateurProfile(),
      },
    );
  }
}

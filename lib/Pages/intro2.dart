import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Kariera/Pages/WelcomePage.dart';
import 'package:Kariera/Pages/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intropage2 extends StatefulWidget {
  Intropage2({super.key});

  @override
  State<Intropage2> createState() => _Intropage2State();
}

class _Intropage2State extends State<Intropage2> {
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      PageView(
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          controller: _controller,
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              color: Colors.white,
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Lottie.network(
                  'https://lottie.host/3fcbed19-750d-443c-93de-865b2117d36d/4NKnGjniVS.json',
                  width: 300,
                  height: 300,
                ),
                const SizedBox(
                  height: 45,
                ),
                Text(
                  "Développez vos connaissances dans de nombreux domaines",
                  style: GoogleFonts.notoSerif(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Container(
              color: const Color.fromARGB(188, 207, 226, 239),
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Lottie.network(
                  'https://lottie.host/d7f3623e-d9c1-4484-8090-de8dcd6c3398/noJ2GBui6Y.json',
                  width: 300,
                  height: 300,
                ),
                const SizedBox(
                  height: 45,
                ),
                Text(
                  "Pratiquez vos Connaissances apprises",
                  style: GoogleFonts.notoSerif(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Container(
              color: Colors.grey[200],
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Lottie.network(
                  'https://lottie.host/6b0b0a7a-fa6c-4b58-896d-7a2414051330/ZKEZt1u4Xi.json',
                  width: 300,
                  height: 300,
                ),
                const SizedBox(
                  height: 45,
                ),
                Text(
                  "Regardez Des Cours Enregistreés",
                  style: GoogleFonts.notoSerif(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ]),
      Container(
          alignment: const Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _controller.jumpToPage(2),
                child: const Text("Skip"),
              ),
              SmoothPageIndicator(controller: _controller, count: 3),
              onLastPage
                  ? GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return WelcomePage();
                        },
                      )),
                      child: const Text("Done"),
                    )
                  : GestureDetector(
                      onTap: () => _controller.nextPage(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.easeIn),
                      child: const Text("Next"),
                    )
            ],
          )),
    ]));
  }
}

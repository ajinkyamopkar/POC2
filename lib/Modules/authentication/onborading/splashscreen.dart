import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getxbase/login.dart';

// import 'home.dart';
// Adjust if necessary

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// void initState() {
//   navigateToNextScreen();
// }

// get context => null;
// // ignore: non_constant_identifier_names
// void navigateToNextScreen() {
//   Future.delayed(const Duration(seconds: 3), () {
//     Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => const Homescreen()),
//         (route) => false);
//   });
// }

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginForm())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/serve-bg.png"), // Adjust path as necessary
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 340,
                      margin: const EdgeInsets.only(top: 400.0),
                      padding:
                          const EdgeInsets.all(15.0), // Padding around the text
                      decoration: BoxDecoration(
                        color: const Color(
                            0xFFFE8C00), // Background color of the box
                        borderRadius:
                            BorderRadius.circular(50), // Rounded corners
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'We serve incomparable delicacies',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10), // Space between texts
                          Text(
                            'All the best restaurants with their top menu waiting for you, they cant’t wait for your order!! sdf',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          SizedBox(height: 80),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Skip",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
//   void initState() {
//     navigateToNextScreen();
//   }

//   get context => null;
//   // ignore: non_constant_identifier_names
//   void navigateToNextScreen() {
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const HomeScreen()),
//           (route) => false);
//     });
//   }
// }

// /* void initState() {
//     Timer(
//        Duration(seconds: 2),
//       () => Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//         ),
//       ),
//     );
//   } */

// // ignore: non_constant_identifier_names

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_focus_todo/constants/images_path.dart';
import 'package:master_focus_todo/screens/home_screen.dart';
import 'package:master_focus_todo/screens/login_screen.dart';
import 'package:master_focus_todo/models/user.dart' as user_model;
import 'package:master_focus_todo/utils/application_info.dart';

const strings = {
  'title': 'Master Focus Todo',
};

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      _redirectToPage();
    });
  }

  void _redirectToPage() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacementNamed(
        LoginScreen.routeName,
      );
    } else {
      final userModel = user_model.User();
      userModel.id = user.uid;
      userModel.name = user.displayName;
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final styleText = GoogleFonts.orbitron(
      fontSize: 28,
      color: Colors.black,
    );
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(
          minHeight: double.maxFinite,
          minWidth: double.maxFinite,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.greenAccent,
              Colors.greenAccent,
              Colors.green,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              splashIcon,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            const SizedBox(
              height: 16,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 8,
            ),
            Text(
              strings['title']!,
              style: styleText,
            ),
            Text(
              ApplicationInfo().versionName,
              style: GoogleFonts.orbitron(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

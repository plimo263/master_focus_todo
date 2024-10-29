import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:master_focus_todo/constants/images_path.dart';
import 'package:master_focus_todo/models/user.dart' as user_model;
import 'package:master_focus_todo/screens/home_screen.dart';
import 'package:master_focus_todo/utils/application_info.dart';

const strings = {
  'label_btn_login_google': 'Login com o Google',
  'label_app_name': 'Master Focus Todo',
  'label_version': 'Versão:',
};

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    // Abre a tela para selecionar a conta
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    // Obtem as credenciais de autenticação da conta do google
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Autentica o usuário com as credenciais obtidas
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      final userModel = user_model.User();
      userModel.id = user.uid;
      userModel.name = user.displayName;
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final styleText = GoogleFonts.orbitron(
        fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: 1);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                tomatoGoodBye,
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(height: 16),
              Text(
                strings['label_app_name']!,
                style: styleText,
              ),
              const SizedBox(height: 16),
              _BtnLoginGoogle(
                onPressed: _isLoading ? null : _signInWithGoogle,
              ),
              const SizedBox(
                height: 16,
              ),
              _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
              Text(
                "${strings['label_version']} ${ApplicationInfo().versionName}",
                style: GoogleFonts.orbitron(
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BtnLoginGoogle extends StatelessWidget {
  final void Function()? onPressed;
  const _BtnLoginGoogle({super.key, this.onPressed});

  Color _getColorForegroundButton(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final styleText = GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );
    return SizedBox(
      width: double.maxFinite,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(
            color: Colors.black45,
            width: 2,
          ),
          foregroundColor: _getColorForegroundButton(context),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(googleLogo),
              height: 24,
            ),
            const SizedBox(width: 16),
            Text(
              strings['label_btn_login_google']!,
              style: styleText,
            ),
          ],
        ),
      ),
    );
  }
}

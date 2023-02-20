import 'package:flutter/material.dart';
import 'package:whatsappclone/colors.dart';
import 'package:whatsappclone/features/auth/screens/login_screen.dart';

import '../../../common/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Welcome to WhatsApp',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height / 9),
          Image.asset(
            'assets/bg.png',
            height: 340,
            width: 340,
          ),
          SizedBox(height: size.height / 12),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: const Text(
              'Read our Privacy Policy. Tap "Agree and Continue" to accept Terms of Service',
              style: TextStyle(
                color: greyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: size.width * 0.75,
            child: CustomButton(
              text: 'Agree and Continue',
              onPressed: () => navigateToLoginScreen(context),
            ),
          ),
        ],
      )),
    );
  }
}

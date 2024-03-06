import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_rubber_sms_app/presentation/screens/signin_screen.dart';

import 'data/constants.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Tea Stock Manager',
      theme: ThemeData().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0x00006e47),
        ),
      ),
      home: const SigninScreen(),
    );
  }
}

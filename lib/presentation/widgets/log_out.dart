import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_rubber_sms_app/data/constants.dart';
import 'package:tea_rubber_sms_app/presentation/screens/signin_screen.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/rounded_button.dart';
import 'package:tea_rubber_sms_app/util/storage_util.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    void logoutHandler() {
      clearAllDataOnStorage();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SigninScreen(),
        ),
        (route) => false,
      );
    }

    return RoundedButton(
      bgColor: const Color(0xB2F0FFEB),
      textColor: Colors.black,
      title: 'Logout',
      icon: const Icon(Icons.logout_outlined),
      width: 200,
      onPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Are you sure?'.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xFF212822),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: Text(
                'Your unsaved data will be lost',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xFF212822),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        AppColors.primary,
                      ),
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                  ),
                ),
                TextButton(
                  onPressed: logoutHandler,
                  child: const Text(
                    'Logout',
                  ),
                ),
              ],
            );
          },
        );
      },
      fontSize: 15,
    );
  }
}

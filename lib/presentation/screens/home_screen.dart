// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_rubber_sms_app/presentation/screens/advance_entry_screen.dart';
import 'package:tea_rubber_sms_app/presentation/screens/advance_view_screen.dart';
import 'package:tea_rubber_sms_app/presentation/screens/collection_view_screen.dart';
import 'package:tea_rubber_sms_app/presentation/screens/daily_collection_screen.dart';
import 'package:tea_rubber_sms_app/presentation/screens/deduction_entry_screen.dart';
import 'package:tea_rubber_sms_app/presentation/screens/deduction_view_screen.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/log_out.dart';

import '../../data/constants.dart';
import '../widgets/rounded_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool?> showExitConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Close all contexts and exit the app
                Navigator.of(context).pop(true);
                SystemNavigator
                    .pop(); // This line closes all routes and exits the app
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        bool? exit = await showExitConfirmationDialog(context);
        return exit ?? false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFFAFEDB3)),
          child: Stack(
            children: [
              // right circle
              Positioned(
                left: 245,
                top: -120,
                child: Container(
                  width: 342,
                  height: 342,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9FE3A3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // left circle
              Positioned(
                left: -273,
                top: -602,
                child: Container(
                  width: 784,
                  height: 784,
                  decoration: const BoxDecoration(
                    color: Color(0xB2F0FFEB),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 60,
                ),
                child: const Column(
                  children: [
                    WelcomeCard(),
                    SizedBox(height: 70),
                    MainMenu(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: LogOut(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: Color(0xFF212822),
      ),
    );

    return SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212822),
                  ),
                ),
              ),
              Text(
                ' Yasith Bandara',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: const Color(0xFF484848),
                    fontSize: deviceWidth > 390 ? 17 : 14,
                    fontWeight: FontWeight.w400,
                    height: 0.05,
                    letterSpacing: -0.24,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 15),
              Container(
                width: 44.52,
                height: 44.52,
                decoration: const ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/user-avatar.png'),
                    fit: BoxFit.cover,
                  ),
                  shape: OvalBorder(
                    side: BorderSide(width: 1.48, color: Color(0xFF006E47)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedButton(
          bgColor: AppColors.primary,
          textColor: Colors.white,
          title: 'Daily Collection',
          width: deviceWidth - 50,
          icon: const Icon(
            Icons.collections_bookmark_outlined,
            color: Colors.white,
          ),
          borderRadius: 20,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DailyCollectionScreen(),
              ),
            );
          },
          fontSize: 15,
        ),
        const SizedBox(height: 10),
        RoundedButton(
          bgColor: AppColors.primary,
          textColor: Colors.white,
          title: 'Collection View',
          width: deviceWidth - 50,
          icon: const Icon(
            Icons.view_agenda_rounded,
            color: Colors.white,
          ),
          borderRadius: 20,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CollectionViewScreen(),
              ),
            );
          },
          fontSize: 15,
        ),
        const SizedBox(height: 10),
        RoundedButton(
          bgColor: AppColors.primary,
          textColor: Colors.white,
          title: 'Advance',
          width: deviceWidth - 50,
          icon: const Icon(
            Icons.monetization_on,
            color: Colors.white,
          ),
          borderRadius: 20,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdvanceViewScreen(),
              ),
            );
          },
          fontSize: 15,
        ),
        const SizedBox(height: 10),
        RoundedButton(
          bgColor: AppColors.primary,
          textColor: Colors.white,
          title: 'Other Deductions',
          width: deviceWidth - 50,
          icon: const Icon(
            Icons.money_off_csred_sharp,
            color: Colors.white,
          ),
          borderRadius: 20,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeductionViewScreen(),
              ),
            );
          },
          fontSize: 15,
        ),
        const SizedBox(height: 26),
        // reqs
        RoundedButton(
          bgColor: AppColors.secondary,
          textColor: Colors.white,
          title: 'Advance Request',
          width: deviceWidth - 50,
          icon: const Icon(
            Icons.request_page,
            color: Colors.white,
          ),
          borderRadius: 20,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdvanceEntryScreen(),
              ),
            );
          },
          fontSize: 15,
        ),
        const SizedBox(height: 10),
        RoundedButton(
          bgColor: AppColors.secondary,
          textColor: Colors.white,
          title: 'Other Deduction Request',
          width: deviceWidth - 50,
          icon: const Icon(
            Icons.request_quote,
            color: Colors.white,
          ),
          borderRadius: 20,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeductionEntryScreen(),
              ),
            );
          },
          fontSize: 15,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

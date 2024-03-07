import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_rubber_sms_app/presentation/screens/daily_collection.dart';

import '../../data/constants.dart';
import '../widgets/rounded_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          children: [
            WelcomeCard(),
            SizedBox(height: 70),
            MainMenu(),
          ],
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
                builder: (context) => const DailyCollection(),
              ),
            );
          },
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
          onPress: () {},
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
          onPress: () {},
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
          onPress: () {},
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
          onPress: () {},
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
          onPress: () {},
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

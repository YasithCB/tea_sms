import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_rubber_sms_app/presentation/screens/home_screen.dart';

import '../../data/constants.dart';
import '../../repo/auth_repo.dart';
import '../../util/common_util.dart';
import '../widgets/rounded_button.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

TextEditingController userIdController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool _isLoading = false;
bool _isPasswordVisible = false;

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9FE3A3),
      resizeToAvoidBottomInset: true,
      body: FocusScope(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
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
                    top: -502,
                    child: Container(
                      width: 784,
                      height: 784,
                      decoration: const BoxDecoration(
                        color: Color(0xB2F0FFEB),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // logo
                  Positioned(
                    left: 7,
                    top: 86,
                    child: Container(
                      width: 301,
                      height: 184,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  // body
                  const Positioned(top: 350, child: InputFields()),

                  // version
                  Positioned(
                    bottom: 7,
                    right: 10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'v1.0.9',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputFields extends StatefulWidget {
  const InputFields({super.key});

  @override
  State<InputFields> createState() => InputFieldsState();
}

class InputFieldsState extends State<InputFields> {
  Future<void> signInHandler() async {
    // final authRepo = AuthRepo();
    // String enteredUserId = userIdController.text.trim();
    // String enteredPassword = passwordController.text;

    // // Validate fields before attempting login
    // if (enteredUserId.isEmpty || enteredPassword.isEmpty) {
    //   showSnackBar(context, 'Please fill required fields');
    //   return;
    // }

    // setState(() {
    //   _isLoading = true;
    // });

    // bool isAuthenticated =
    //     await authRepo.sendAuthReq(context, enteredUserId, enteredPassword);

    // setState(() {
    //   _isLoading = false;
    // });

    // if (isAuthenticated) {
    //   // clear fields
    //   userIdController.clear();
    //   passwordController.clear();

    //   // ignore: use_build_context_synchronously
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const HomeScreen(),
    //     ),
    //   );
    // }

    // dev time only
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 62,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              scrollPadding: const EdgeInsets.only(bottom: 200),
              controller: userIdController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                hintText: 'User ID',
                hintStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xFF3B3B3B),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 13,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              scrollPadding: const EdgeInsets.only(bottom: 170),
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Password',
                hintStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xFF3B3B3B),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 13,
                ),
                suffixIcon: IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: RoundedButton(
                          bgColor: AppColors.primary,
                          textColor: Colors.white,
                          title: 'Sign In',
                          width: 140.0,
                          icon: const Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          ),
                          borderRadius: 20,
                          onPress: signInHandler,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

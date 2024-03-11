import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.prompt,
    required this.isIconNeed,
    required this.isLabelNeeded,
    this.icon,
    this.onPressIcon,
  });

  final String label;
  final String prompt;
  final TextEditingController controller;
  final bool isIconNeed;
  final bool isLabelNeeded;
  final Icon? icon;
  final void Function()? onPressIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLabelNeeded
                    ? Text(
                        label,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0xFF212822),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 5),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: prompt,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48),
                      borderSide: const BorderSide(
                        width: 0.92,
                        color: Color(0xFFD8DADC),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48),
                      borderSide: const BorderSide(
                        width: 0.92,
                        color: Color(0xFFD8DADC),
                      ),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color(0xFF41423C),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isIconNeed
              ? Padding(
                padding: const EdgeInsets.only(top: 27),
                child: IconButton(
                  icon: icon!,
                  onPressed: onPressIcon,
                ),
              )
              : const SizedBox(),
        ],
      ),
    );
  }
}

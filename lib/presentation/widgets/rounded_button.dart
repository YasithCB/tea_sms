import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.textColor,
    required this.width,
    required this.onPress,
    this.borderWidth,
    this.borderRadius,
    this.icon,
  });

  final String title;
  final Color bgColor;
  final Color textColor;
  final double width;
  final Function() onPress;
  final double? borderWidth;
  final double? borderRadius;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        height: 48,
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 77.91),
            side: borderWidth != null
                ? BorderSide(
                    color: textColor,
                    width: borderWidth!,
                  )
                : BorderSide(width: 0, color: bgColor),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 37.84,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: textColor,
                    fontSize: deviceWidth > 370 ? 16 : 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              icon == null ? const SizedBox() : const SizedBox(width: 10),
              icon ?? const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

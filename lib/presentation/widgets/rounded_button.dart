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
    this.height,
    required this.onPress,
    required this.fontSize,
    this.borderWidth,
    this.borderRadius,
    this.icon,
  });

  final String title;
  final Color bgColor;
  final Color textColor;
  final double width;
  final double? height;
  final Function() onPress;
  final double fontSize;
  final double? borderWidth;
  final double? borderRadius;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        height: height?? 45,
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
                    fontSize: deviceWidth > 370 ? fontSize : fontSize - 3,
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

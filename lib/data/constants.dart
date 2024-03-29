import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppColors {
  static Color primary = const Color(0xFF006E47);
  static Color secondary = const Color(0xFF6DB03F);
  static Color warning = const Color(0xFFEA5455);
  static Color grey = const Color(0xFF5E5873);
}

var alertStyle = AlertStyle(
  alertElevation: 0,
  backgroundColor: Colors.white,
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 200),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);

// const String baseUrl = 'http://100.27.0.141:8080';
const String baseUrl = 'http://54.91.8.217:8080';

late double deviceWidth;
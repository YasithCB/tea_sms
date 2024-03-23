import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/constants.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key, required this.label, required this.onChanged});

  final String label;
  final ValueChanged<bool>? onChanged;

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            fillColor: MaterialStateProperty.all(
                isChecked ? AppColors.primary : Colors.white),
            value: isChecked,
            onChanged: (_) {
              setState(() {
                isChecked = !isChecked;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(isChecked);
              }
            },
          ),
          Text(
            widget.label,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

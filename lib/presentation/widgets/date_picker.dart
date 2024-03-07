import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/date_time_util.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key});

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          setState(() {
            selectedDate = date;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color(0xFF212822),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.92, color: Color(0xFFD8DADC)),
                  borderRadius: BorderRadius.circular(48),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDate(selectedDate),
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF41423C),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icons/calender-dot.png',
                    height: 24,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

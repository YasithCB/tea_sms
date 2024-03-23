import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/rounded_button.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/textfield.dart';

class AddNewCustomer extends StatefulWidget {
  const AddNewCustomer({super.key});

  @override
  State<AddNewCustomer> createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Text(
            'Add New Customer',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF151515),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // subtitle
          Text(
            'Please enter customer details below and tap add button to add.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 25),

          // customer name
          MyTextField(
            label: 'Customer name',
            prompt: 'Eg : Saman Weerasiri',
            isIconNeed: false,
            isLabelNeeded: true,
            controller: nameController,
          ),

          // contact number
          MyTextField(
            label: 'Customer Contact Number',
            prompt: 'Eg : 0761234567',
            isIconNeed: false,
            isLabelNeeded: true,
            controller: nameController,
          ),
          const SizedBox(height: 15),

          // btns
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: RoundedButton(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  bgColor: const Color(0xFFE2E2E2),
                  textColor: const Color(0xFF151515),
                  title: 'Cancel',
                  width: 120,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RoundedButton(
                  onPress: () {
                    
                  },
                  bgColor: const Color(0xFF006E47),
                  textColor: Colors.white,
                  title: 'Add',
                  width: 120.0,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/constants.dart';
import '../widgets/rounded_button.dart';
import '../widgets/textfield.dart';

class SearchUserModal extends StatefulWidget {
  const SearchUserModal(
      {super.key, required this.onConfirm, required this.onCancel});

  final Function() onConfirm;
  final Function() onCancel;

  @override
  State<SearchUserModal> createState() => _SearchUserModalState();
}

class _SearchUserModalState extends State<SearchUserModal> {
  final TextEditingController userNameController = TextEditingController();
  String searchBy = 'Name';
  List<String> searchByList = ['Name', 'Contact', 'Reg No'];

  String decideLabelText() {
    switch (searchBy) {
      case 'Name':
        return 'User Name';
      case 'Contact':
        return 'Contact Number';
      case 'Reg No':
        return 'Register Number';
      default:
        return '';
    }
  }

  String decidePromptText() {
    switch (searchBy) {
      case 'Name':
        return 'User Name';
      case 'Contact':
        return 'Contact Number';
      case 'Reg No':
        return 'Register Number';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Text(
            'Search User',
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
            'Search user by his name or contact number',
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

          // selection dropdown
          Row(
            children: [
              Text(
                'Search By  :      ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xFF212822),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              DropdownButton<String>(
                value: searchBy,
                onChanged: (String? newValue) {
                  setState(() {
                    searchBy = newValue!;
                  });
                },
                items: searchByList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xFF212822),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // search by name
          MyTextField(
            label: decideLabelText(),
            prompt: decidePromptText(),
            isIconNeed: false,
            onPressIcon: () {},
            isLabelNeeded: true,
            controller: userNameController,
          ),

          const SizedBox(height: 25),

          // btns
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: RoundedButton(
                  onPress: widget.onCancel,
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
                  onPress: widget.onConfirm,
                  bgColor: const Color(0xFF006E47),
                  textColor: Colors.white,
                  title: 'Search',
                  width: 120.0,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

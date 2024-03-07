import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_rubber_sms_app/presentation/screens/home_screen.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/checkbox.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/date_picker.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/textfield.dart';
import 'package:tea_rubber_sms_app/util/common_util.dart';

import '../../data/constants.dart';
import '../../data/db.dart';
import '../widgets/rounded_button.dart';

class DailyCollection extends StatefulWidget {
  const DailyCollection({super.key});

  @override
  State<DailyCollection> createState() => _DailyCollectionState();
}

class _DailyCollectionState extends State<DailyCollection> {
  TextEditingController regNoController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController deductionController = TextEditingController();
  TextEditingController noOfBagsController = TextEditingController();
  String selectedDeduction = deductionsList[0];

  double netWeight = 0;
  double waterDeduction = 0;
  double bagWeightDeduction = 0;

  bool _isLoading = false;

  calcNetWeight() {
    if (grossWeightController.text == '' || deductionController.text == '') {
      showSnackBar(context, 'Please fill required fields!');
      return;
    }
    if (netWeight == 0) {
      netWeight = double.tryParse(grossWeightController.text) ?? 0;
    }
    setState(() {
      initDeduction();
      netWeight -= double.tryParse(deductionController.text) ?? 0;
    });
    deductionController.clear();
  }

  initDeduction() {
    switch (selectedDeduction) {
      case 'Water':
        waterDeduction += double.tryParse(deductionController.text) ?? 0;
        break;
      case 'Bag Weight':
        bagWeightDeduction += double.tryParse(deductionController.text) ?? 0;
        break;
    }
  }

  navigateBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            children: [
              // header
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset('assets/icons/back.png', height: 36),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Daily Collection',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF212822),
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              // body
              Container(
                width: deviceWidth * 0.9,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 37.84,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // date
                      const MyDatePicker(),
                      // Reg no
                      MyTextField(
                        label: 'Register Number',
                        controller: regNoController,
                        prompt: 'Enter Reg Number of User',
                        isIconNeed: true,
                        icon: Icon(Icons.search, color: AppColors.primary),
                        onPressIcon: () {},
                        isLabelNeeded: true,
                      ),

                      // display name
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Name   : Yasith Chathuranga Bandara',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xFF212822),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      // checkbox - leafe type
                      Text(
                        'Leaf Type',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0xFF212822),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          MyCheckBox(label: 'Normal'),
                          MyCheckBox(label: 'Supper'),
                        ],
                      ),

                      // checkbox - sms
                      const Row(
                        children: [
                          MyCheckBox(label: 'Need a SMS Alert'),
                        ],
                      ),

                      // no of bags
                      MyTextField(
                        label: 'No of Bags',
                        controller: noOfBagsController,
                        prompt: '0',
                        isIconNeed: false,
                        isLabelNeeded: true,
                      ),
                      // gross weight kg
                      MyTextField(
                        label: 'Gross Weight Kg',
                        controller: grossWeightController,
                        prompt: '0',
                        isIconNeed: false,
                        isLabelNeeded: true,
                      ),

                      // dropdown
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Deduction',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF212822),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              DropdownButton<String>(
                                value: selectedDeduction,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedDeduction = newValue!;
                                  });
                                },
                                items: deductionsList.map((String value) {
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
                          const SizedBox(width: 15),
                          Expanded(
                            child: MyTextField(
                              label: '',
                              controller: deductionController,
                              prompt: '0',
                              isIconNeed: false,
                              isLabelNeeded: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: calcNetWeight,
                            child: Icon(
                              Icons.add_box_outlined,
                              color: AppColors.primary,
                              size: 30,
                            ),
                          )
                        ],
                      ),

                      // display name
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Net Weight Kg   : $netWeight',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xFF212822),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // table
                      Table(
                        border: TableBorder.all(),
                        children: [
                          const TableRow(children: [
                            Text(''),
                            Center(child: Text('Kg')),
                          ]),
                          TableRow(children: [
                            const TableCell(child: Center(child: Text('Bags'))),
                            Center(child: Text(noOfBagsController.text)),
                          ]),
                          TableRow(children: [
                            const Center(child: Text('Water')),
                            Center(child: Text(waterDeduction.toString())),
                          ]),
                          TableRow(children: [
                            const Center(child: Text('Bag Weight')),
                            Center(child: Text(bagWeightDeduction.toString())),
                          ]),
                        ],
                      ),

                      const SizedBox(height: 30),

                      //  btns
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    title: 'Cancel',
                                    bgColor: const Color(0xFFE2E2E2),
                                    textColor: Colors.black,
                                    width: 100,
                                    onPress: navigateBack,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: RoundedButton(
                                    title: 'Submit',
                                    bgColor: AppColors.primary,
                                    textColor: Colors.white,
                                    width: 100,
                                    onPress: () {},
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

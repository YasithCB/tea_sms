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

class CollectionViewScreen extends StatefulWidget {
  const CollectionViewScreen({super.key});

  @override
  State<CollectionViewScreen> createState() => _CollectionViewScreenState();
}

class _CollectionViewScreenState extends State<CollectionViewScreen> {
  TextEditingController regNoController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController deductionController = TextEditingController();
  TextEditingController noOfBagsController = TextEditingController();
  String selectedDeduction = deductionsList[0];

  double netWeight = 0;
  double waterDeduction = 0;
  double bagWeightDeduction = 0;

  double dayTotalCollection = 0;
  double supplierMonthTotalCollection = 0;

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
                    onTap: navigateBack,
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
                      const MyDatePicker(title: 'Date'),
                      // Day View search btns
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    title: 'Day View',
                                    bgColor: const Color(0xFFE2E2E2),
                                    textColor: Colors.black,
                                    width: 100,
                                    onPress: navigateBack,
                                    fontSize: 13,
                                    height: 40,
                                  ),
                                ),
                              ],
                            ),

                      // Reg no
                      MyTextField(
                        label: 'Register Number',
                        controller: regNoController,
                        prompt: 'Enter Reg Number of Supplier',
                        isIconNeed: false,
                        isLabelNeeded: true,
                      ),

                      // Supplier Collection search btns
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    title: 'Supplier Collection',
                                    bgColor: AppColors.primary,
                                    textColor: Colors.white,
                                    width: 100,
                                    onPress: () {},
                                    fontSize: 13,
                                    height: 40,
                                  ),
                                ),
                              ],
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

                      const SizedBox(height: 15),

                      // table
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Day Total View',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(7),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(1),
                        },
                        children: [
                          const TableRow(children: [
                            Center(
                                child: Text(
                              'No',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                            Center(
                                child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                            Center(
                              child: Text(
                                'Net Kg',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(),
                          ]),
                          TableRow(children: [
                            const Center(
                                child: Text(
                              '1002',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                            const Center(
                                child: Text(
                              'Mr.Kumarasiri',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                            const Center(
                              child: Text(
                                '48',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.delete_forever,
                                  size: 18,
                                  color: AppColors.warning,
                                ),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const SizedBox(),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                                child: Text(
                              dayTotalCollection.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                            const SizedBox(),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // table 2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Supplier Month Collection',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(7),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(1),
                        },
                        children: [
                          const TableRow(children: [
                            Center(
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Net Kg',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(),
                          ]),
                          TableRow(children: [
                            const Center(
                                child: Text(
                              '10/03/2024',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                            const Center(
                              child: Text(
                                '48',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.delete_forever,
                                  size: 18,
                                  color: AppColors.warning,
                                ),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                supplierMonthTotalCollection.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(),
                          ]),
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

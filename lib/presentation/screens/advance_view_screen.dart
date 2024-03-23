import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_rubber_sms_app/presentation/screens/home_screen.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/date_picker.dart';

import '../../data/constants.dart';
import '../widgets/rounded_button.dart';

class AdvanceViewScreen extends StatefulWidget {
  const AdvanceViewScreen({super.key});

  @override
  State<AdvanceViewScreen> createState() => _AdvanceViewScreenState();
}

class _AdvanceViewScreenState extends State<AdvanceViewScreen> {
  TextEditingController regNoController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController deductionController = TextEditingController();
  TextEditingController noOfBagsController = TextEditingController();

  double thisMonthLeaf = 0;
  double prevMonthLeaf = 0;

  String selectedDeductionType = 'Fertilizer';
  List<String> deductionTypeList = [
    'Fertilizer',
    'Tea',
    'Dolomite',
    'Chemical',
    'Rice'
  ];
  String selectedInstallment = '1';
  List<String> installmentsList = ['1', '2', '3'];

  bool _isLoading = false;

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
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        navigateBack();
        return true;
      },
      child: Scaffold(
        body: FocusScope(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Column(
                  children: [
                    // header
                    Row(
                      children: [
                        GestureDetector(
                          onTap: navigateBack,
                          child:
                              Image.asset('assets/icons/back.png', height: 36),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          'Advance View',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xFF212822),
                              fontSize: 20,
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
                            // Affected Date
                            const MyDatePicker(title: 'Date'),
                            const SizedBox(height: 15),

                            // search user
                            Row(
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    title: 'Day View',
                                    icon: const Icon(Icons.search,
                                        color: Colors.white),
                                    bgColor: AppColors.primary,
                                    textColor: Colors.white,
                                    width: 100,
                                    onPress: () {},
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            // table
                            Table(
                              border: TableBorder.all(),
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(5),
                                2: FlexColumnWidth(2),
                              },
                              children: const [
                                TableRow(
                                  children: [
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
                                      'Amount',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Center(
                                        child: Text(
                                      '1002',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                    Center(
                                        child: Text(
                                      'Yasith Chathuranga Bandara',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                    Center(
                                        child: Text(
                                      '2800',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

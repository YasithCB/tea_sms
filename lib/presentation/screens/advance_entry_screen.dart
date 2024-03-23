import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tea_rubber_sms_app/presentation/models/search_user.dart';
import 'package:tea_rubber_sms_app/presentation/screens/home_screen.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/date_picker.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/textfield.dart';

import '../../data/constants.dart';
import '../../data/db.dart';
import '../widgets/rounded_button.dart';

class AdvanceEntryScreen extends StatefulWidget {
  const AdvanceEntryScreen({super.key});

  @override
  State<AdvanceEntryScreen> createState() => _AdvanceEntryScreenState();
}

class _AdvanceEntryScreenState extends State<AdvanceEntryScreen> {
  TextEditingController regNoController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController deductionController = TextEditingController();
  TextEditingController noOfBagsController = TextEditingController();
  String selectedDeduction = deductionsList[0];

  double thisMonthLeaf = 0;
  double prevMonthLeaf = 0;

  bool _isLoading = false;
  bool _isSearchedByDate = true;

  navigateBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  showSearchUserModel() {
    setState(() {
      _isSearchedByDate = false;
    });

    Alert(
      context: context,
      style: alertStyle,
      content:
          const Padding(padding: EdgeInsets.zero, child: SearchUserModal()),
      buttons: [],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchedByUser = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Affected Date
        const MyDatePicker(title: 'Affected Date'),

        const SizedBox(height: 25),

        // display name
        Text(
          'Name   : Yasith Chathuranga Bandara',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xFF212822),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'This Month Leaf             : $thisMonthLeaf',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xFF212822),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Previous Month Leaf     : $prevMonthLeaf',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xFF212822),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // gross weight kg
        MyTextField(
          label: 'Amount',
          controller: grossWeightController,
          prompt: '0',
          isIconNeed: false,
          isLabelNeeded: true,
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
                      fontSize: 15,
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
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
      ],
    );

    Widget searchedByDate = Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(7),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(1),
      },
      children: [
        const TableRow(
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
            Center(
              child: Padding(padding: EdgeInsets.all(4.0), child: SizedBox()),
            ),
          ],
        ),
        TableRow(
          children: [
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
              'Yasith Chathuranga Bandara',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            )),
            const Center(
                child: Text(
              '2800',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            )),
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
          ],
        ),
      ],
    );

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
                          'Advance Booking/Entry',
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
                            // Issue Date
                            const MyDatePicker(title: 'Issue Date'),
                            // search user
                            Row(
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    title: 'Search Advance by Date',
                                    icon: const Icon(Icons.search,
                                        color: Colors.white),
                                    bgColor: AppColors.primary,
                                    textColor: Colors.white,
                                    width: 100,
                                    onPress: () {
                                      setState(() {
                                        _isSearchedByDate = true;
                                      });
                                    },
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                'Or',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF212822),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),

                            // search user
                            Row(
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    title: 'Add a Advance',
                                    icon: const Icon(Icons.monetization_on_outlined,
                                        color: Colors.white),
                                    bgColor: AppColors.primary,
                                    textColor: Colors.white,
                                    width: 100,
                                    onPress: showSearchUserModel,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            _isSearchedByDate ? searchedByDate : searchedByUser
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

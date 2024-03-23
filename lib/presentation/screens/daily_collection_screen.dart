import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tea_rubber_sms_app/cubit/searchby_regno_cubit.dart';
import 'package:tea_rubber_sms_app/data/model/collection.dart';
import 'package:tea_rubber_sms_app/presentation/models/add_new_customer.dart';
import 'package:tea_rubber_sms_app/presentation/models/search_user.dart';
import 'package:tea_rubber_sms_app/presentation/screens/home_screen.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/checkbox.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/date_picker.dart';
import 'package:tea_rubber_sms_app/presentation/widgets/textfield.dart';
import 'package:tea_rubber_sms_app/repo/collection_repo.dart';
import 'package:tea_rubber_sms_app/util/common_util.dart';

import '../../data/constants.dart';
import '../../data/db.dart';
import '../widgets/rounded_button.dart';

class DailyCollectionScreen extends StatefulWidget {
  const DailyCollectionScreen({super.key});

  @override
  State<DailyCollectionScreen> createState() => _DailyCollectionScreenState();
}

class _DailyCollectionScreenState extends State<DailyCollectionScreen> {
  TextEditingController regNoController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController deductionController = TextEditingController();
  TextEditingController noOfBagsController = TextEditingController();
  String selectedDeduction = deductionsList[0];

  final CollectionRepo _collectionRepo = CollectionRepo();

  String selectedLeafType = 'Normal';
  double netWeight = 0;
  double waterDeduction = 0;
  double bagWeightDeduction = 0;
  bool isSmsNeed = false;
  List<Deduction> dedeuctionsList = [];

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
    // add to list
    dedeuctionsList.add(
      Deduction(
        type: selectedDeduction,
        deduct: int.parse(deductionController.text),
      ),
    );

    // update table
    switch (selectedDeduction) {
      case 'Water':
        waterDeduction += double.tryParse(deductionController.text) ?? 0;
        break;
      case 'Bag Weight':
        bagWeightDeduction += double.tryParse(deductionController.text) ?? 0;
        break;
    }
  }

  saveCollection() async {
    setState(() {
      _isLoading = true;
    });

    final collection = Collection(
      name: selectedCustomer!.name,
      registerNumber: selectedCustomer!.registerNumber,
      trDay: DateTime.now().day,
      trMonth: DateFormat('MMM-yy').format(DateTime.now()),
      trDate: DateFormat('M/d/yyyy').format(DateTime.now()),
      route: 'Balangoda',
      qty: int.parse(netWeight.toString()),
      vehicle: 'None',
      trRate: 4,
      gross: int.parse(grossWeightController.text),
      ws: 'N/A',
      incRate: 0,
      commissionRate: 0,
      grade: selectedLeafType,
      sms: isSmsNeed,
      deductions: dedeuctionsList,
    );

    final isSaveSuccess = await _collectionRepo.saveCollection(collection);
    setState(() {
      _isLoading = false;
    });
    if (isSaveSuccess) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Collection Entry Successfull!');
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

  showSearchUserModel() {
    Alert(
      context: context,
      style: alertStyle,
      content:
          const Padding(padding: EdgeInsets.zero, child: SearchUserModal()),
      buttons: [],
    ).show();
  }

  showAddNewCustomerModal() {
    Alert(
      context: context,
      style: alertStyle,
      content: const Padding(padding: EdgeInsets.zero, child: AddNewCustomer()),
      buttons: [],
    ).show();
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

                            // search user
                            Row(
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    title: 'Search User',
                                    icon: const Icon(Icons.search,
                                        color: Colors.white),
                                    bgColor: AppColors.primary,
                                    textColor: Colors.white,
                                    width: 100,
                                    onPress: showSearchUserModel,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                IconButton(
                                    onPressed: showAddNewCustomerModal,
                                    icon: const Icon(Icons.add_box_outlined))
                              ],
                            ),
                            const SizedBox(height: 15),

                            // display name
                            BlocBuilder<SearchUserCubit, SearchUserState>(
                              builder: (context, state) {
                                if (state.status == SearchUserStatus.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.status ==
                                        SearchUserStatus.loaded &&
                                    selectedCustomer != null) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Text(
                                      'Name   : ${selectedCustomer!.name}',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),

                            // selected user today records

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
                            Row(
                              children: [
                                Radio(
                                  value: 'Normal',
                                  groupValue: selectedLeafType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedLeafType = value!;
                                    });
                                  },
                                ),
                                const Text('Normal'),
                                Radio(
                                  value: 'Supper',
                                  groupValue: selectedLeafType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedLeafType = value!;
                                    });
                                  },
                                ),
                                const Text('Supper'),
                              ],
                            ),

                            // checkbox - sms
                            Row(
                              children: [
                                MyCheckBox(
                                  label: 'Need a SMS Alert',
                                  onChanged: (bool value) {
                                    isSmsNeed = value;
                                  },
                                ),
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
                              columnWidths: const {
                                0: FlexColumnWidth(8),
                                1: FlexColumnWidth(2),
                              },
                              children: [
                                const TableRow(children: [
                                  Text(''),
                                  Center(child: Text('Kg')),
                                ]),
                                TableRow(children: [
                                  const TableCell(
                                      child: Center(child: Text('Bags'))),
                                  Center(child: Text(noOfBagsController.text)),
                                ]),
                                TableRow(children: [
                                  const Center(child: Text('Water')),
                                  Center(
                                      child: Text(waterDeduction.toString())),
                                ]),
                                TableRow(children: [
                                  const Center(child: Text('Bag Weight')),
                                  Center(
                                      child:
                                          Text(bagWeightDeduction.toString())),
                                ]),
                              ],
                            ),

                            const SizedBox(height: 30),

                            //  btns
                            _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/constants.dart';

class DailyCollection extends StatefulWidget {
  const DailyCollection({super.key});

  @override
  State<DailyCollection> createState() => _DailyCollectionState();
}

class _DailyCollectionState extends State<DailyCollection> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                    GestureDetector(
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
                              AppLocalization.of(context)
                                  .getTranslatedValues("date")
                                  .toString(),
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF212822),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.92, color: Color(0xFFD8DADC)),
                                  borderRadius: BorderRadius.circular(48),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatDate(selectedDate),
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF41423C),
                                        fontSize: 14.78,
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
                    ),
                    // start date
                    GestureDetector(
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: selectedStartDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(() {
                            selectedStartDate = date;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalization.of(context)
                                  .getTranslatedValues("startDate")
                                  .toString(),
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF212822),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.92, color: Color(0xFFD8DADC)),
                                  borderRadius: BorderRadius.circular(48),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    formatDate(selectedStartDate),
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF41423C),
                                        fontSize: 14.78,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //  start time
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: selectedStartTime,
                          initialEntryMode: TimePickerEntryMode.dialOnly,
                          builder: (BuildContext context, Widget? child) {
                            // We just wrap these environmental changes around the
                            // child in this builder so that we can apply the
                            // options selected above. In regular usage, this is
                            // rarely necessary, because the default values are
                            // usually used as-is.
                            return Theme(
                              data: Theme.of(context).copyWith(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                textTheme: TextTheme(
                                  displayLarge: const TextStyle(
                                    fontSize: 55,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  bodyMedium: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                    alwaysUse24HourFormat: true,
                                  ),
                                  child: child!,
                                ),
                              ),
                            );
                          },
                        );

                        if (time != null) {
                          setState(() {
                            selectedStartTime = time;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalization.of(context)
                                  .getTranslatedValues("startTime")
                                  .toString(),
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF212822),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.92, color: Color(0xFFD8DADC)),
                                  borderRadius: BorderRadius.circular(48),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    formatTime(selectedStartTime),
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF41423C),
                                        fontSize: 14.78,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // finish date
                    GestureDetector(
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: selectedFinishDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(() {
                            selectedFinishDate = date;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalization.of(context)
                                  .getTranslatedValues("finishDate")
                                  .toString(),
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF212822),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.92, color: Color(0xFFD8DADC)),
                                  borderRadius: BorderRadius.circular(48),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    formatDate(selectedFinishDate),
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF41423C),
                                        fontSize: 14.78,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //  finish time
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: selectedFinishTime,
                          initialEntryMode: TimePickerEntryMode.dialOnly,
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                textTheme: TextTheme(
                                  displayLarge: const TextStyle(
                                    fontSize: 55,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  bodyMedium: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                    alwaysUse24HourFormat: true,
                                  ),
                                  child: child!,
                                ),
                              ),
                            );
                          },
                        );

                        if (time != null) {
                          setState(() {
                            selectedFinishTime = time;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalization.of(context)
                                  .getTranslatedValues("finishTime")
                                  .toString(),
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF212822),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.92, color: Color(0xFFD8DADC)),
                                  borderRadius: BorderRadius.circular(48),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    formatTime(selectedFinishTime),
                                    style: const TextStyle(
                                      color: Color(0xFF41423C),
                                      fontSize: 14.78,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // store
                    // DropdownSearch<String>(
                    //   popupProps: const PopupProps.menu(
                    //     showSelectedItems: true,
                    //   ),
                    //   items: storeList,
                    //   dropdownDecoratorProps: DropDownDecoratorProps(
                    //     dropdownSearchDecoration: InputDecoration(
                    //       labelText: AppLocalization.of(context)
                    //           .getTranslatedValues("store")
                    //           .toString(),
                    //       hintText: "",
                    //     ),
                    //   ),
                    //   onChanged: (value) {
                    //     selectedStore = value!;
                    //   },
                    //   selectedItem: selectedStore,
                    // ),

                    // const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalization.of(context)
                              .getTranslatedValues("store")
                              .toString(),
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xFF212822),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Store',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: storeList
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedStore,
                              onChanged: (value) {
                                setState(() {
                                  selectedStore = value!;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 200,
                              ),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                              dropdownSearchData: DropdownSearchData(
                                searchController: storeSearchController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    controller: storeSearchController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: 'Select a Store',
                                      hintStyle: const TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchValue.toLowerCase());
                                },
                              ),
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  storeSearchController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // event
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalization.of(context)
                              .getTranslatedValues("event")
                              .toString(),
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xFF212822),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Event',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: eventList
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedEvent,
                              onChanged: (value) {
                                setState(() {
                                  selectedEvent = value!;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 200,
                              ),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                              dropdownSearchData: DropdownSearchData(
                                searchController: eventSearchController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    controller: eventSearchController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: 'Select a Event',
                                      hintStyle: const TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchValue.toLowerCase());
                                },
                              ),
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  eventSearchController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    //  btns
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: RoundedButton(
                                  title: AppLocalization.of(context)
                                      .getTranslatedValues("cancel")
                                      .toString(),
                                  bgColor: const Color(0xFFE2E2E2),
                                  textColor: Colors.black,
                                  width: 100,
                                  onPress: navigateBack,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: RoundedButton(
                                  title: AppLocalization.of(context)
                                      .getTranslatedValues("submit")
                                      .toString(),
                                  bgColor: AppColors.primary,
                                  textColor: Colors.white,
                                  width: 100,
                                  onPress: submitHandler,
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
    );
  }
}

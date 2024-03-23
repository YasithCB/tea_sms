import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_rubber_sms_app/cubit/searchby_regno_cubit.dart';
import 'package:tea_rubber_sms_app/data/model/customer.dart';

import '../widgets/rounded_button.dart';
import '../widgets/textfield.dart';

class SearchUserModal extends StatefulWidget {
  const SearchUserModal({super.key});

  @override
  State<SearchUserModal> createState() => _SearchUserModalState();
}

class _SearchUserModalState extends State<SearchUserModal> {
  final TextEditingController searchTextController = TextEditingController();
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

  void searchHandler(BuildContext context) async {
    switch (searchBy) {
      case 'Name':
        break;
      case 'Contact':
        break;
      case 'Reg No':
        context
            .read<SearchUserCubit>()
            .searchByRegNo(searchTextController.text);
        break;
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
            'Search user by his register number/ name or contact number',
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
            controller: searchTextController,
          ),

          const SizedBox(height: 10),

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
                    searchHandler(context);
                  },
                  bgColor: const Color(0xFF006E47),
                  textColor: Colors.white,
                  title: 'Search',
                  width: 120.0,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // searched user list
          const FilteredUsersList(),
        ],
      ),
    );
  }
}

class FilteredUsersList extends StatefulWidget {
  const FilteredUsersList({super.key});

  @override
  State<FilteredUsersList> createState() => FilteredUsersListState();
}

class FilteredUsersListState extends State<FilteredUsersList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUserCubit, SearchUserState>(
      builder: (context, state) {
        if (state.status == SearchUserStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == SearchUserStatus.loaded) {
          return Column(
            children: state.customers
                .map((customer) => CustomerTile(customer: customer))
                .toList(),
          );
        } else if (state.status == SearchUserStatus.error) {
          return Center(
            child: Text(state.error ??
                'Error while loading'), // Show error message if available
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class CustomerTile extends StatelessWidget {
  const CustomerTile({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SearchUserCubit>().selectCustomer(customer);
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          title: Text(
            customer.name,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF212822),
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          subtitle: Text(
            customer.mobile,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF212822),
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

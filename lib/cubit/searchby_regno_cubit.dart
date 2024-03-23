import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_rubber_sms_app/data/db.dart';
import 'package:tea_rubber_sms_app/data/model/customer.dart';
import 'package:tea_rubber_sms_app/repo/collection_repo.dart';
import 'package:tea_rubber_sms_app/repo/user_repo.dart';

enum SearchUserStatus { initial, loading, loaded, error }

class SearchUserState {
  final SearchUserStatus status;
  final List<Customer> customers;
  final String? error;

  const SearchUserState({
    this.status = SearchUserStatus.initial,
    this.customers = const [],
    this.error,
  });

  SearchUserState copyWith({
    SearchUserStatus? status,
    List<Customer>? customers,
    String? error,
  }) {
    return SearchUserState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      error: error ?? this.error,
    );
  }
}

class SearchUserCubit extends Cubit<SearchUserState> {
  final UserRepo _userRepo = UserRepo();
  final CollectionRepo _collectionRepo = CollectionRepo();

  SearchUserCubit() : super(SearchUserState(status: SearchUserStatus.initial));

  Future<void> searchByRegNo(String regNo) async {
    emit(state.copyWith(status: SearchUserStatus.loading));
    try {
      final customer = await _userRepo.searchUserByRegNo(regNo);
      emit(state.copyWith(
        status: SearchUserStatus.loaded,
        customers: customer == null ? [] : [customer],
      ));
    } catch (e) {
      emit(state.copyWith(
          status: SearchUserStatus.error,
          error: 'Error searching by regNo: $e'));
    }
  }

  Future<void> selectCustomer(Customer customer) async {
    emit(state.copyWith(status: SearchUserStatus.loading));
    selectedCustomer = customer;

    // load today collections list
    todayCollectionsOfSelectedCustomer =
        await _collectionRepo.getTodayCollectionsByRegNo(
      customer.registerNumber.toString(),
    );
    emit(state.copyWith(
      status: SearchUserStatus.loaded,
    ));
  }
}

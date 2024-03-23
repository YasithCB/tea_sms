import 'package:tea_rubber_sms_app/data/model/collection.dart';
import 'package:tea_rubber_sms_app/data/model/customer.dart';

late String accessToken;

List<String> deductionsList = [
  'Water',
  'Bag Weight',
];

Customer? selectedCustomer;
List<Collection> todayCollectionsOfSelectedCustomer = [];

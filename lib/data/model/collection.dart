// ignore_for_file: public_member_api_docs, sort_constructors_first
class Collection {
  final String name;
  final int registerNumber;
  final int trDay;
  final String trMonth;
  final String trDate;
  final String route;
  final int qty;
  final String vehicle;
  final int trRate;
  final int gross;
  final String ws;
  final int incRate;
  final int commissionRate;
  final String grade;
  final bool sms;
  final List<Deduction> deductions;

  Collection({
    required this.name,
    required this.registerNumber,
    required this.trDay,
    required this.trMonth,
    required this.trDate,
    required this.route,
    required this.qty,
    required this.vehicle,
    required this.trRate,
    required this.gross,
    required this.ws,
    required this.incRate,
    required this.commissionRate,
    required this.grade,
    required this.sms,
    required this.deductions,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      name: json['name'] as String,
      registerNumber: json['registerNumber'] as int,
      trDay: json['trDay'] as int,
      trMonth: json['trMonth'] as String,
      trDate: json['trDate'] as String,
      route: json['route'] as String,
      qty: json['qty'] as int,
      vehicle: json['vehicle'] as String,
      trRate: json['trRate'] as int,
      gross: json['gross'] as int,
      ws: json['ws'] as String,
      incRate: json['incRate'] as int,
      commissionRate: json['commissionRate'] as int,
      grade: json['grade'] as String,
      sms: json['sms'] as bool,
      deductions: (json['deductions'] as List<dynamic>)
          .map((e) => Deduction.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'registerNumber': registerNumber,
      'trDay': trDay,
      'trMonth': trMonth,
      'trDate': trDate,
      'route': route,
      'qty': qty,
      'vehicle': vehicle,
      'trRate': trRate,
      'gross': gross,
      'ws': ws,
      'incRate': incRate,
      'commissionRate': commissionRate,
      'grade': grade,
      'sms': sms,
      'deductions': deductions.map((e) => e.toJson()).toList(),
    };
  }
}

class Deduction {
  final String type;
  final int deduct;

  Deduction({
    required this.type,
    required this.deduct,
  });

  factory Deduction.fromJson(Map<String, dynamic> json) {
    return Deduction(
      type: json['type'] as String,
      deduct: json['deduct'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'deduct': deduct,
    };
  }
}

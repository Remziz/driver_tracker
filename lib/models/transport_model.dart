import 'package:equatable/equatable.dart';

class TransportModel extends Equatable {
  final String model;
  final String driver;
  final String status;

  factory TransportModel.fromMap(Map<String, dynamic> map) {
    return TransportModel(
      model: map['model'],
      driver: map['driver'],
      status: map['status'],
    );
  }

  const TransportModel(
      {required this.model, required this.driver, required this.status});

  @override
  List<Object> get props => [model, driver, status];
}

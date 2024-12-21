import 'package:equatable/equatable.dart';

class TransportModel extends Equatable {
  final int id;
  final String model;
  final String driver;
  final String status;

  factory TransportModel.fromMap(Map<String, dynamic> map) {
    return TransportModel(
      id: map['id'],
      model: map['model'],
      driver: map['driver'],
      status: map['status'],
    );
  }

  const TransportModel({
    required this.id,
    required this.model,
    required this.driver,
    required this.status,
  });

  @override
  List<Object> get props => [id, model, driver, status];
}

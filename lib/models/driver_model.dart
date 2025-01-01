import 'package:equatable/equatable.dart';

class DriverModel extends Equatable {
  final int id;
  final String name;

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      id: map['id'],
      name: map['name'],
    );
  }
  const DriverModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}

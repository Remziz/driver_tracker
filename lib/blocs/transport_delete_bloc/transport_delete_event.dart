part of 'transport_delete_bloc.dart';

final class TransportDeleteEvent extends Equatable {
  const TransportDeleteEvent(
    this.id,
    this.driver,
    this.transportModel,
    this.status,
  );

  final int id;
  final String driver;
  final String transportModel;
  final String status;

  @override
  List<Object> get props => [id, driver, transportModel, status];
}

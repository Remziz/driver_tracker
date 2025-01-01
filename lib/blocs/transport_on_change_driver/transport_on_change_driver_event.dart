part of 'transport_on_change_driver_bloc.dart';

sealed class TransportOnChangeDriverEvent extends Equatable {
  const TransportOnChangeDriverEvent();

  @override
  List<Object> get props => [];
}

final class ChangingExistDriverEvent extends TransportOnChangeDriverEvent {
  final int index;
  final String driverName;

  const ChangingExistDriverEvent(
    this.index,
    this.driverName,
  );

  @override
  List<Object> get props => [index, driverName];
}

final class SaveChangeToExistDriverEvent extends TransportOnChangeDriverEvent {
  final int id;
  final String transportModel;
  final String status;
  final String driverName;

  const SaveChangeToExistDriverEvent(
    this.id,
    this.status,
    this.driverName,
    this.transportModel,
  );

  @override
  List<Object> get props => [driverName];
}

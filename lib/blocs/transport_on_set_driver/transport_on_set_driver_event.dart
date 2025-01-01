part of 'transport_on_set_driver_bloc.dart';

sealed class TransportOnSetDriverEvent extends Equatable {
  const TransportOnSetDriverEvent();

  @override
  List<Object> get props => [];
}

final class DriverChangedEvent extends TransportOnSetDriverEvent {
  final int id;
  final String name;

  const DriverChangedEvent(
    this.name,
    this.id,
  );

  @override
  List<Object> get props => [id, name];
}

final class DriverSaveChangedEvent extends TransportOnSetDriverEvent {
  final int id;
  final String name;

  const DriverSaveChangedEvent(
    this.id,
    this.name,
  );

  @override
  List<Object> get props => [id, name];
}

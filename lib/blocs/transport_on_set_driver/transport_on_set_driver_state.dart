part of 'transport_on_set_driver_bloc.dart';

sealed class TransportOnSetDriverState extends Equatable {
  const TransportOnSetDriverState();

  @override
  List<Object> get props => [];
}

final class TransportOnSetDriverInitial extends TransportOnSetDriverState {}

final class ChangingDriverState extends TransportOnSetDriverState {
  final int id;
  final String name;

  const ChangingDriverState(
    this.name,
    this.id,
  );

  @override
  List<Object> get props => [id, name];
}

final class ChangedDriverState extends TransportOnSetDriverState {
  final int id;
  final String name;

  const ChangedDriverState(
    this.id,
    this.name,
  );

  @override
  List<Object> get props => [id, name];
}

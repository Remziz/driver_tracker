part of 'transport_on_change_driver_bloc.dart';

sealed class TransportOnChangeDriverState extends Equatable {
  const TransportOnChangeDriverState();

  @override
  List<Object> get props => [];
}

final class TransportOnChangeDriverInitial
    extends TransportOnChangeDriverState {}

final class ChangingExistDriverState extends TransportOnChangeDriverState {
  final int index;
  final String driverName;

  const ChangingExistDriverState(
    this.index,
    this.driverName,
  );

  @override
  List<Object> get props => [index, driverName];
}

final class ChangedExistDriverState extends TransportOnChangeDriverState {
  final String driverName;

  const ChangedExistDriverState(
    this.driverName,
  );

  @override
  List<Object> get props => [driverName];
}

final class ChangedLoadDriverState extends TransportOnChangeDriverState {}

final class ChangedExistDriverSuccesfully
    extends TransportOnChangeDriverState {}

final class ChangedExistDriverFailure extends TransportOnChangeDriverState {}

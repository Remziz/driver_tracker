part of 'transport_driver_bloc.dart';

sealed class TransportDriverState extends Equatable {
  const TransportDriverState();

  @override
  List<Object> get props => [];
}

final class TransportDriverInitial extends TransportDriverState {}

final class TransportDriverLoading extends TransportDriverState {}

final class TransportDriverLoaded extends TransportDriverState {
  final List<DriverModel> driverList;

  const TransportDriverLoaded(
    this.driverList,
  );
}

final class TransportDriverLoadFailure extends TransportDriverState {}

part of 'transport_add_bloc.dart';

sealed class TransportAddEvent extends Equatable {
  const TransportAddEvent();

  @override
  List<Object> get props => [];
}

final class SelectedNewTransportEvent extends TransportAddEvent {
  final String item;

  const SelectedNewTransportEvent(
    this.item,
  );
  @override
  List<Object> get props => [item];
}

final class OnAddTransportEvent extends TransportAddEvent {
  final String modelName;
  final String driverName;
  final String status;

  const OnAddTransportEvent(
    this.modelName,
    this.driverName,
    this.status,
  );

  @override
  List<Object> get props => [modelName, driverName, status];
}

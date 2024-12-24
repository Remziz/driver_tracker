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

  const OnAddTransportEvent(
    this.modelName,
  );

  @override
  List<Object> get props => [modelName];
}

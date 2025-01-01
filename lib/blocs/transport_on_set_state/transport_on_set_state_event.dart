part of 'transport_on_set_state_bloc.dart';

sealed class TransportOnSetStateEvent extends Equatable {
  const TransportOnSetStateEvent();

  @override
  List<Object> get props => [];
}

final class StateChangedEvent extends TransportOnSetStateEvent {
  final int index;
  final String status;

  const StateChangedEvent(
    this.index,
    this.status,
  );

  @override
  List<Object> get props => [status];
}

final class StateSaveChangedEvent extends TransportOnSetStateEvent {
  final int index;
  final String status;

  const StateSaveChangedEvent(
    this.index,
    this.status,
  );

  @override
  List<Object> get props => [status];
}

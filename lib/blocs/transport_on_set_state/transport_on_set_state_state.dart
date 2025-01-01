part of 'transport_on_set_state_bloc.dart';

sealed class TransportOnSetStateState extends Equatable {
  const TransportOnSetStateState();

  @override
  List<Object> get props => [];
}

final class TransportOnSetStateInitial extends TransportOnSetStateState {}

final class ChangingStateOnAdd extends TransportOnSetStateState {
  final int index;
  final String status;

  const ChangingStateOnAdd(
    this.index,
    this.status,
  );
  @override
  List<Object> get props => [index, status];
}

final class ChangedStateOnAddLoading extends TransportOnSetStateState {}

final class ChangedStateOnAdd extends TransportOnSetStateState {
  final int index;
  final String status;

  const ChangedStateOnAdd(
    this.index,
    this.status,
  );
  @override
  List<Object> get props => [status];
}

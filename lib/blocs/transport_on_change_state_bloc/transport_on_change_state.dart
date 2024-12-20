part of 'transport_on_change_bloc.dart';

sealed class TransportOnChangeState extends Equatable {
  const TransportOnChangeState();

  @override
  List<Object> get props => [];
}

final class TransportOnChangeInitial extends TransportOnChangeState {}

final class TransportChangedState extends TransportOnChangeState {
  final int selectedIndex;
  final String action;
  final String driver;

  const TransportChangedState(
    this.selectedIndex,
    this.action,
    this.driver,
  );

  @override
  List<Object> get props => [selectedIndex, action, driver];
}

final class OnChangedState extends TransportOnChangeState {
  final String action;

  const OnChangedState(this.action);

  @override
  List<Object> get props => [action];
}

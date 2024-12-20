part of 'transport_on_change_bloc.dart';

sealed class TransportOnChangeEvent extends Equatable {
  const TransportOnChangeEvent();

  @override
  List<Object> get props => [];
}

final class OnChangeStateEvent extends TransportOnChangeEvent {
  final int selectedIndex;
  final String action;
  final String driver;

  const OnChangeStateEvent(
    this.selectedIndex,
    this.action,
    this.driver,
  );

  @override
  List<Object> get props => [selectedIndex, action, driver];
}

final class OnSaveButtonEvent extends TransportOnChangeEvent {
  final String action;
  final String driver;

  const OnSaveButtonEvent(
    this.action,
    this.driver,
  );

  @override
  List<Object> get props => [action, driver];
}

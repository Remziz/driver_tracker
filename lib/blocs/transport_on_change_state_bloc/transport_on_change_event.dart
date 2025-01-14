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
  final int id;
  final String driver;
  final String transportModel;
  final String action;

  const OnSaveButtonEvent(
    this.id,
    this.driver,
    this.transportModel,
    this.action,
  );

  @override
  List<Object> get props => [id, driver, transportModel, action];
}

part of 'transport_driver_bloc.dart';

sealed class TransportDriverEvent extends Equatable {
  const TransportDriverEvent();

  @override
  List<Object> get props => [];
}

final class TransportDriverLoadEvent extends TransportDriverEvent {
  final String userId;

  const TransportDriverLoadEvent(
    this.userId,
  );

  @override
  List<Object> get props => [userId];
}

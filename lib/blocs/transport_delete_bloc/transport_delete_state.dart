part of 'transport_delete_bloc.dart';

sealed class TransportDeleteState extends Equatable {
  const TransportDeleteState();

  @override
  List<Object> get props => [];
}

final class TransportDeleteInitial extends TransportDeleteState {}

final class TransportDeletingState extends TransportDeleteState {}

final class TransportDeletedState extends TransportDeleteState {}

final class TransportFailureDeleteState extends TransportDeleteState {}

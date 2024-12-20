part of 'transport_bloc.dart';

sealed class TransportState extends Equatable {
  const TransportState();

  @override
  List<Object> get props => [];
}

final class TransportInitial extends TransportState {}

final class TransportLoading extends TransportState {}

final class TransportLoaded extends TransportState {
  final List<TransportModel> transportData;

  const TransportLoaded(this.transportData);

  @override
  List<Object> get props => [transportData];
}

final class TransportLoadingFailure extends TransportState {}

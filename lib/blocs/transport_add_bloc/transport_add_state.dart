part of 'transport_add_bloc.dart';

sealed class TransportAddState extends Equatable {
  const TransportAddState();

  @override
  List<Object> get props => [];
}

final class TransportAddInitial extends TransportAddState {}

final class TransportChangedDropdown extends TransportAddState {
  final String selectedItem;

  const TransportChangedDropdown(
    this.selectedItem,
  );

  @override
  List<Object> get props => [selectedItem];
}

final class TransportAdding extends TransportAddState {}

final class TransportAdded extends TransportAddState {}

final class TransportAddFailure extends TransportAddState {}

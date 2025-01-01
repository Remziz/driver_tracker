import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'transport_on_set_state_event.dart';
part 'transport_on_set_state_state.dart';

class TransportOnSetStateBloc
    extends Bloc<TransportOnSetStateEvent, TransportOnSetStateState> {
  final SupabaseClient supabase;
  TransportOnSetStateBloc(this.supabase) : super(TransportOnSetStateInitial()) {
    on<StateChangedEvent>((event, emit) {
      final int index = event.index;
      final String status = event.status;
      emit(ChangingStateOnAdd(index, status));
    });
    on<StateSaveChangedEvent>((event, emit) {
      final int index = event.index;
      final String status = event.status;
      emit(ChangedStateOnAdd(index, status));
    });
  }
}

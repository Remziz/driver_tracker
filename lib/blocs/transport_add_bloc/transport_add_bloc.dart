import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'transport_add_event.dart';
part 'transport_add_state.dart';

class TransportAddBloc extends Bloc<TransportAddEvent, TransportAddState> {
  final SupabaseClient supabase;
  TransportAddBloc(this.supabase) : super(TransportAddInitial()) {
    on<SelectedNewTransportEvent>((event, emit) {
      final selectedItem = event.item;
      emit(TransportChangedDropdown(selectedItem));
    });
    on<OnAddTransportEvent>((event, emit) async {
      emit(TransportAdding());
      final modelName = event.modelName;
      final driverName = event.driverName;
      final status = event.status;
      final userId = supabase.auth.currentUser!.id;
      try {
        await supabase.from('vehicels').insert({
          'user_id': userId,
          'model': modelName,
          'driver': driverName,
          'status': status,
        });
        emit(TransportAdded());
      } catch (e) {
        emit(TransportAddFailure());
      }
    });
  }
}

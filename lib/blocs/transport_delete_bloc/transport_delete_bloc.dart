import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'transport_delete_event.dart';
part 'transport_delete_state.dart';

class TransportDeleteBloc
    extends Bloc<TransportDeleteEvent, TransportDeleteState> {
  final SupabaseClient supabase;
  TransportDeleteBloc(this.supabase) : super(TransportDeleteInitial()) {
    on<TransportDeleteEvent>((event, emit) async {
      emit(TransportDeletingState());
      final int id = event.id;
      final String driver = event.driver;
      final String transportModel = event.transportModel;
      final String status = event.status;
      try {
        await supabase
            .from('vehicels')
            .delete()
            .eq('id', id)
            .eq('driver', driver)
            .eq('model', transportModel)
            .eq('status', status);
        emit(TransportDeletedState());
      } catch (e) {
        emit(TransportFailureDeleteState());
      }
    });
  }
}

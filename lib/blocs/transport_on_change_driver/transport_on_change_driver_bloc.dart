import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'transport_on_change_driver_event.dart';
part 'transport_on_change_driver_state.dart';

class TransportOnChangeDriverBloc
    extends Bloc<TransportOnChangeDriverEvent, TransportOnChangeDriverState> {
  final SupabaseClient supabase;
  TransportOnChangeDriverBloc(this.supabase)
      : super(TransportOnChangeDriverInitial()) {
    on<ChangingExistDriverEvent>((event, emit) {
      final int index = event.index;
      final String driverName = event.driverName;

      emit(ChangingExistDriverState(index, driverName));
    });
    on<SaveChangeToExistDriverEvent>((event, emit) async {
      emit(ChangedLoadDriverState());
      final String userId = supabase.auth.currentUser!.id;
      final int id = event.id;
      final String status = event.status;
      final String transportModel = event.transportModel;
      final String driverName = event.driverName;

      try {
        await supabase
            .from('vehicels')
            .update({'driver': driverName})
            .eq('user_id', userId)
            .eq('id', id)
            .eq('status', status)
            .eq('model', transportModel);
        emit(ChangedExistDriverSuccesfully());
      } catch (e) {
        emit(ChangedExistDriverFailure());
      }
    });
  }
}

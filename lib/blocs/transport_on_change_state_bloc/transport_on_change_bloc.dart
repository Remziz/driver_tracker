import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'transport_on_change_event.dart';
part 'transport_on_change_state.dart';

class TransportOnChangeBloc
    extends Bloc<TransportOnChangeEvent, TransportOnChangeState> {
  final SupabaseClient supabase;
  TransportOnChangeBloc(this.supabase) : super(TransportOnChangeInitial()) {
    on<OnChangeStateEvent>((event, emit) {
      final int index = event.selectedIndex;
      final String action = event.action;
      final String driver = event.driver;
      emit(TransportChangedState(index, action, driver));
    });
    on<OnSaveButtonEvent>((event, emit) async {
      emit(ChangingState());
      final int id = event.id;
      final String action = event.action;
      final String userId = supabase.auth.currentUser!.id;
      final String driver = event.driver;
      final String model = event.transportModel;
      try {
        await supabase
            .from('vehicels')
            .update({'status': action})
            .eq('id', id)
            .eq('user_id', userId)
            .eq('driver', driver)
            .eq('model', model);
        emit(ChangedStateSuccessuful());
      } catch (e) {
        emit(ChangedStateFailure());
      }
    });
  }
}

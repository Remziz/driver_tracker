import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vehical_app/models/transport_model.dart';

part 'transport_event.dart';
part 'transport_state.dart';

class TransportBloc extends Bloc<TransportEvent, TransportState> {
  final SupabaseClient supabase;
  TransportBloc(this.supabase) : super(TransportInitial()) {
    on<LoadTransportData>((event, emit) async {
      emit(TransportLoading());
      try {
        final response = await supabase
            .from('vehicels')
            .select()
            .eq('user_id', event.userId);
        final transportData =
            (response as List).map((e) => TransportModel.fromMap(e)).toList();
        emit(TransportLoaded(transportData));
      } catch (e) {
        emit(TransportLoadingFailure());
      }
    });
    on<OnChangedStateEvent>((event, emit) {
      final index = event.selectedIndex;
      emit(TransportSelectedState(index));
    });
  }
}

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
        List<TransportModel> transportData =
            (response as List).map((e) => TransportModel.fromMap(e)).toList();
        transportData.sort((a, b) => a.id.compareTo(b.id));
        emit(TransportLoaded(transportData));
      } catch (e) {
        emit(TransportLoadingFailure());
      }
    });
  }
}

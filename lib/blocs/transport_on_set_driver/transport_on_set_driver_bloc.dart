import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'transport_on_set_driver_event.dart';
part 'transport_on_set_driver_state.dart';

class TransportOnSetDriverBloc
    extends Bloc<TransportOnSetDriverEvent, TransportOnSetDriverState> {
  final SupabaseClient supabase;
  TransportOnSetDriverBloc(this.supabase)
      : super(TransportOnSetDriverInitial()) {
    on<DriverChangedEvent>((event, emit) {
      final int id = event.id;
      final String name = event.name;
      emit(ChangingDriverState(name, id));
    });
    on<DriverSaveChangedEvent>((event, emit) {
      final int id = event.id;
      final String name = event.name;
      emit((ChangedDriverState(id, name)));
    });
  }
}

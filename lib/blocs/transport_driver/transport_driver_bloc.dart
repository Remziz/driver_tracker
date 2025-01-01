import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vehical_app/models/driver_model.dart';

part 'transport_driver_event.dart';
part 'transport_driver_state.dart';

class TransportDriverBloc
    extends Bloc<TransportDriverEvent, TransportDriverState> {
  final SupabaseClient supabase;
  TransportDriverBloc(this.supabase) : super(TransportDriverInitial()) {
    on<TransportDriverLoadEvent>((event, emit) async {
      final String userId = event.userId;
      emit(TransportDriverLoading());
      try {
        final response = await supabase.from('drivers').select().eq(
              'user_id',
              userId,
            );
        List<DriverModel> driverList = (response as List)
            .map((element) => DriverModel.fromMap(element))
            .toList();
        driverList.sort((a, b) => a.id.compareTo(b.id));
        emit(TransportDriverLoaded(driverList));
      } catch (e) {
        emit(TransportDriverLoadFailure());
      }
    });
  }
}

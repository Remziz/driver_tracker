import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final SupabaseClient supabase;
  AuthBloc(this.supabase) : super(AuthInitial()) {
    on<OnStartEvent>((event, emit) {
      final session = supabase.auth.currentSession;
      if (session != null) {
        emit(AuthSucess());
      } else {
        emit(UnAuthenticated());
      }
    });
    on<OnLoginButtonEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await supabase.auth.signInWithPassword(
          email: event.email.trim(),
          password: event.password.trim(),
        );
        emit(AuthSucess());
      } catch (e) {
        emit(AuthFailure());
      }
    });
    on<LogOut>((event, emit) async {
      await supabase.auth.signOut();
      add(OnStartEvent());
    });
  }
}

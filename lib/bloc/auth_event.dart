part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class OnStartEvent extends AuthEvent {}

final class OnLoginButtonEvent extends AuthEvent {
  final String email;
  final String password;

  OnLoginButtonEvent({
    required this.email,
    required this.password,
  });
}

final class LogOut extends AuthEvent {}

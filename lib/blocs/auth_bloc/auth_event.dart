part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {}

final class OnStartEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

final class OnLoginButtonEvent extends AuthEvent {
  final String email;
  final String password;

  OnLoginButtonEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

final class LogOut extends AuthEvent {
  @override
  List<Object?> get props => [];
}

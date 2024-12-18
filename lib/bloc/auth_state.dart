part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthInitial extends AuthBlocState {}

final class AuthSucess extends AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class AuthFailure extends AuthBlocState {}

final class UnAuthenticated extends AuthBlocState {}

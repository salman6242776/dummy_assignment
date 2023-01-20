part of 'authorize_bloc.dart';

@immutable
abstract class AuthorizeEvent {}

class AuthorizeUserEvent extends AuthorizeEvent {
  UserModel userModel;
  AuthorizeUserEvent({required this.userModel});
}

class AutoAuthorizeEvent extends AuthorizeEvent {
  AutoAuthorizeEvent();
}

class LogoutUserEvent extends AuthorizeEvent {
  LogoutUserEvent();
}

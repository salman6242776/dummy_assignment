part of 'authorize_bloc.dart';

@immutable
abstract class AuthorizeState {}

class AuthorizeInitial extends AuthorizeState {}

class AuthorizeStarted extends AuthorizeState {}

class AuthorizeSuccessful extends AuthorizeState {}

class AuthorizeFailed extends AuthorizeState {}

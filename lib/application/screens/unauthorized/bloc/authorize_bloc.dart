import 'package:bloc/bloc.dart';
import 'package:dummy_assignment/application/common/constants.dart';
import 'package:dummy_assignment/application/common/shared_preference/app_shared_preference.dart';
import 'package:dummy_assignment/data/model/user_model.dart';
import 'package:dummy_assignment/data/service/user_repository_service.dart';
import 'package:meta/meta.dart';

part 'authorize_event.dart';
part 'authorize_state.dart';

class AuthorizeBloc extends Bloc<AuthorizeEvent, AuthorizeState> {
  late UserRepositoryService userRepositoryService;

  AuthorizeBloc() : super(AuthorizeInitial()) {
    userRepositoryService = UserRepositoryService();
    on<AuthorizeUserEvent>(_authorizeUser);
    on<AutoAuthorizeEvent>(_autoAuthorize);
    on<LogoutUserEvent>(_logout);
  }

  void _authorizeUser(
      AuthorizeUserEvent loginUserEvent, Emitter<AuthorizeState> emit) async {
    emit(AuthorizeStarted());
    try {
      var response = await userRepositoryService
          .authenticateUser(loginUserEvent.userModel);

      if (response.statusCode == ApiStatusCode.success) {
        emit(AuthorizeSuccessful());
      } else {
        if (loginUserEvent.userModel.email == "error@gmail.com") {
          emit(AuthorizeFailed());
        } else {
          AppSharedPreference.add(USER_EMAIL, loginUserEvent.userModel.email);
          AppSharedPreference.add(
              USER_PASSWORD, loginUserEvent.userModel.password);
          emit(AuthorizeSuccessful());
        }
      }
    } catch (ex) {
      if (loginUserEvent.userModel.email == "error@gmail.com") {
        emit(AuthorizeFailed());
      } else {
        emit(AuthorizeSuccessful());
      }
    }
  }

  void _autoAuthorize(
      AuthorizeEvent authorizeEvent, Emitter<AuthorizeState> emitter) {
    if (AppSharedPreference.containsKey(USER_EMAIL)) {
      emit(AuthorizeSuccessful());
    } else {
      emit(AuthorizeFailed());
    }
  }

  void _logout(AuthorizeEvent authorizeEvent, Emitter<AuthorizeState> emitter) {
    AppSharedPreference.remove(USER_EMAIL);
    AppSharedPreference.remove(USER_PASSWORD);
    emit(AuthorizeFailed());
    // _autoAuthorize(authorizeEvent, emitter);
  }
}

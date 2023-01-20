import 'package:dummy_assignment/application/common/constants.dart';
import 'package:dummy_assignment/data/service/api_keys.dart';
import 'package:http/http.dart' as http;

import '../../data/model/user_model.dart';
import '../../domain/repository/user_repository.dart';

class UserRepositoryService implements UserRepository {
  @override
  Future<http.Response> authenticateUser(UserModel userModel) async {
    var uri = Uri.https(BASE_URL, ApiEndpoints.login);
    var bodyObject = {
      ApiKeys.EMAIL: userModel.email,
      ApiKeys.PASSWORD: userModel.password,
    };
    print('API $uri, request: $bodyObject');
    var response = await http.post(uri, body: bodyObject);
    print('API $uri, reponse: $response');
    return response;
  }
}

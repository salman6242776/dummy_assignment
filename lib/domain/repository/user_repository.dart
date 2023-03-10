import 'package:http/http.dart' as http;
import '../../data/model/user_model.dart';

abstract class UserRepository {
  Future<bool> authenticateUser(UserModel userModel);
}

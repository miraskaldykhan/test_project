import 'package:test_project/api/users_provider.dart';
import 'package:test_project/models/users.dart';

class UsersRepository{
  final UsersProvider _usersProvider = UsersProvider();
  Future<UsersList> getAllUsers() => _usersProvider.getUsersList();
  Future<Users> getUserByLogin(String login) => _usersProvider.getUserByLogin(login);
}

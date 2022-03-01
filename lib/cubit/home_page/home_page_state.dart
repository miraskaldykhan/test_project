import 'package:test_project/models/users.dart';

abstract class UsersState{}

class UsersLoadingState extends UsersState{}

class UsersLoadedState extends UsersState{
  UsersList loadedUsers;
  UsersLoadedState({required this.loadedUsers});
}
class UsersErrorState extends UsersState{}
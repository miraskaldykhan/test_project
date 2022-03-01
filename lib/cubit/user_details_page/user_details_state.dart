import 'package:test_project/models/users.dart';

abstract class UserState{}

class UserLoadingState extends UserState{}

class UserLoadedState extends UserState{
  Users loadedUser;
  UserLoadedState({required this.loadedUser});
}
class UserErrorState extends UserState{}
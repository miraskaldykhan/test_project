import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/api/users_repository.dart';
import 'package:test_project/models/users.dart';

import 'user_details_state.dart';

class UserCubit extends Cubit<UserState>{
  final UsersRepository usersRepository;

  UserCubit({required this.usersRepository}) : super(UserLoadingState());

  Future<void> fetchUser(String login) async{
    try{
      final Users _loadedUser = await usersRepository.getUserByLogin(login);
      emit(UserLoadedState(loadedUser: _loadedUser));
    }catch(_){
      emit(UserErrorState());
    }
  }
}
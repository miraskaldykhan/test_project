import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/api/users_repository.dart';
import 'package:test_project/cubit/home_page/home_page_state.dart';
import 'package:test_project/models/users.dart';

class UsersCubit extends Cubit<UsersState>{
  final UsersRepository usersRepository;

  UsersCubit({required this.usersRepository}) : super(UsersLoadingState());

  Future<void> fetchUsers() async{
    try{
      final UsersList _loadedUsersList = await usersRepository.getAllUsers();
      emit(UsersLoadedState(loadedUsers: _loadedUsersList));
    }catch(_){
      emit(UsersErrorState());
    }
  }
}
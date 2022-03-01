import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/home_page.dart';

import 'api/users_repository.dart';
import 'cubit/home_page/home_page_cubit.dart';
import 'cubit/user_details_page/user_details_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final usersRepository = UsersRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersCubit>(
          create: (context) => UsersCubit(usersRepository: usersRepository),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(usersRepository: usersRepository),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

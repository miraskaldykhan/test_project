import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/cubit/home_page/home_page_cubit.dart';
import 'package:test_project/cubit/home_page/home_page_state.dart';
import 'package:test_project/screens/users_list.dart';

import 'api/users_repository.dart';
import 'cubit/user_details_page/user_details_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Tests APp by Miras'),
          centerTitle: true,
        ),
        body: const UsersListPage(),
      );
  }
}

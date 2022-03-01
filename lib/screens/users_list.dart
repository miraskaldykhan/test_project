import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/cubit/home_page/home_page_cubit.dart';
import 'package:test_project/cubit/home_page/home_page_state.dart';
import 'package:test_project/screens/user_details.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final ScrollController _scrollController = ScrollController();
  bool loading = false, allLoaded = false;

  loadingNewUsers() async {
    //Я сделал этот метод как имитацию загрузки новых пользователей
    // так как я не смог разобраться как загружать больше данных с api.github
    // у меня на это оставалось потратить тока 2-3 часа чтобы успеть сделать остальные части
    // так как я вторник вечером уезжаю в другой город а с утра у меня дела, поэтому я начал делать начиная
    //  с 20:00 вечера до 23:00 потом утром 2-3 часа и все это можно было сделать с cubit но я не успею
    // подключить
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(microseconds: 500));
    setState(() {
      loading = false;
      allLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        loadingNewUsers();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UsersCubit userCubit = context.read<UsersCubit>();
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is UsersLoadingState) {
          userCubit.fetchUsers();
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UsersLoadedState) {
          return Stack(
            children: [
              RefreshIndicator(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.loadedUsers.users.length + (allLoaded ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < state.loadedUsers.users.length) {
                      return Card(
                        child: ListTile(
                          title: Text(state.loadedUsers.users[index].login),
                          subtitle: Text('#${state.loadedUsers.users[index].id}'),
                          leading: Image.network(
                              state.loadedUsers.users[index].avatarUrl),
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => UserDetails(
                                        login: state.loadedUsers.users[index].login)));
                          },
                        ),
                      );
                    } else {
                      return const Card(
                        child: Text("Noting more to load"),
                      );
                    }
                  },
                ),
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 1), () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("PAge refreshed"),
                    ));
                  });
                },
              ),
              if (loading) ...[
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ]
            ],
          );
        }
        if (state is UsersErrorState) {
          return const Center(
            child: Text(
              'Error loading users',
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

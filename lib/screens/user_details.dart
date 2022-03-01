import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/cubit/user_details_page/user_details_cubit.dart';
import 'package:test_project/cubit/user_details_page/user_details_state.dart';

class UserDetails extends StatefulWidget {
  final String login;

  const UserDetails({Key? key, required this.login}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = context.read<UserCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.login}'s info"),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          userCubit.fetchUser(widget.login);
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserLoadedState) {
            return Card(
              child: ListTile(
                title: Text(state.loadedUser.login),
                subtitle: Text('#${state.loadedUser.id}  || ${state.loadedUser.following}'),
                leading: Image.network(state.loadedUser.avatarUrl),

              ),
            );
          }
          if (state is UserErrorState) {
            return const Center(
              child: Text(
                'Error loading users',
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

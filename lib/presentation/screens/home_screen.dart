import 'package:firebase_project/core/extensions/size_extension.dart';
import 'package:firebase_project/core/utils/loader_dialog_util.dart';
import 'package:firebase_project/data/repository/person_repository_impl.dart';
import 'package:firebase_project/presentation/cubits/add_user/add_user_cubit.dart';
import 'package:firebase_project/presentation/cubits/fetch_users/fetch_users_cubit.dart';
import 'package:firebase_project/presentation/cubits/remove_user/remove_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final personRepository = PersonRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AddUserCubit(personRepository),
        ),
        BlocProvider(
          create: (_) => FetchUsersCubit(personRepository)..listenUsers(),
        ),
        BlocProvider(
          create: (_) => RemoveUserCubit(personRepository),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Realtime Project'),
        ),
        floatingActionButton: BlocConsumer<AddUserCubit, AddUserState>(
          listener: (context, state) {
            if (state.isLoading) {
              DialogUtils(context).showLoader();
            }
            if (state.isSuccess) {
              DialogUtils(context).hideLoader();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: state.isLoading ? null : () => context.read<AddUserCubit>().createUser(),
              child: const Icon(Icons.add),
            );
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: context.h * 0.01,
              ),
              Expanded(
                child: BlocBuilder<FetchUsersCubit, FetchUsersState>(
                  builder: (context, state) {
                    return Card(
                      color: Colors.grey[200],
                      child: state.users.isEmpty
                          ? const Center(
                              child: Text('The user list is empty'),
                            )
                          : ListView.separated(
                              separatorBuilder: (_, index) => const Divider(),
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                final user = state.users[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(user.name),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(user.lastName),
                                        Text('Age: ${user.age}'),
                                      ],
                                    ),
                                    trailing: (user.uid!.isEmpty)
                                        ? const SizedBox.shrink()
                                        : BlocBuilder<RemoveUserCubit, RemoveUserState>(
                                            builder: (context, state) {
                                              return ElevatedButton(
                                                onPressed: () {
                                                  context
                                                      .read<RemoveUserCubit>()
                                                      .removeUser(user.uid!);
                                                },
                                                style: IconButton.styleFrom(
                                                  backgroundColor: Colors.redAccent,
                                                  shape: const CircleBorder(),
                                                  elevation: 2,
                                                ),
                                                child: const Icon(
                                                  Icons.delete_forever_outlined,
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                );
                              },
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:firebase_project/domain/entities/person_entity.dart';
import 'package:firebase_project/domain/repository/person_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_users_state.dart';
part 'fetch_users_cubit.freezed.dart';

class FetchUsersCubit extends Cubit<FetchUsersState> {
  final PersonRepository _repository;
  StreamSubscription? _subscription;
  FetchUsersCubit(this._repository) : super(const FetchUsersState());

  void listenUsers() async {
    // Emit loading state
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      // Listen changes in database
      _subscription = _repository.fetchAllUsers().listen((event) {
        // Emit changes to UI
        emit(state.copyWith(
          users: event,
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        hasError: true,
      ));
    }
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}

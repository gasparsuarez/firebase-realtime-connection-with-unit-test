import 'package:firebase_project/domain/entities/person_entity.dart';
import 'package:firebase_project/domain/repository/person_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_user_state.dart';
part 'add_user_cubit.freezed.dart';

class AddUserCubit extends Cubit<AddUserState> {
  final PersonRepository _repository;
  AddUserCubit(this._repository) : super(const AddUserState());

  /// Add new user to Firestore
  void createUser() async {
    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      isSuccess: false,
      message: '',
    ));
    try {
      final user = PersonEntity(
        name: 'John',
        lastName: 'Doe',
        age: '34',
      );

      final successResponse = await _repository.addUser(user);
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        message: successResponse,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        message: 'Error has been occurred',
      ));
    }
  }
}

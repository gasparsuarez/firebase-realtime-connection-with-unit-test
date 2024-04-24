import 'package:firebase_project/domain/repository/person_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_user_state.dart';
part 'remove_user_cubit.freezed.dart';

class RemoveUserCubit extends Cubit<RemoveUserState> {
  final PersonRepository _repository;
  RemoveUserCubit(this._repository) : super(const RemoveUserState());

  void removeUser(String uid) async {
    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
    ));
    try {
      final successMessage = await _repository.removeUser(uid);
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        message: successMessage,
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

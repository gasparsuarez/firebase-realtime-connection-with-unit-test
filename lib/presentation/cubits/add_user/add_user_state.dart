part of 'add_user_cubit.dart';

@freezed
class AddUserState with _$AddUserState {
  const factory AddUserState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool hasError,
    @Default('') String message,
  }) = _AddUserState;
}

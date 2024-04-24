part of 'remove_user_cubit.dart';

@freezed
class RemoveUserState with _$RemoveUserState {
  const factory RemoveUserState({
    @Default(false) bool isSuccess,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String message,
  }) = _RemoveUserState;
}

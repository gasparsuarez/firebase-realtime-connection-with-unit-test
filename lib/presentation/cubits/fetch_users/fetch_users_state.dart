part of 'fetch_users_cubit.dart';

@freezed
class FetchUsersState with _$FetchUsersState {
  const factory FetchUsersState({
    @Default([]) List<PersonEntity> users,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
  }) = _FetchUsersState;
}

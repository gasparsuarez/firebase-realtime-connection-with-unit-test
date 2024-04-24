import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_project/data/repository/person_repository_impl.dart';
import 'package:firebase_project/presentation/cubits/remove_user/remove_user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<PersonRepositoryImpl>()])
import 'add_user_cubit_test.mocks.dart';

void main() {
  group(
    'Remove User Cubit',
    () {
      late MockPersonRepositoryImpl mockPersonRepositoryImpl;
      late RemoveUserCubit removeUserCubit;

      setUp(
        () {
          mockPersonRepositoryImpl = MockPersonRepositoryImpl();
          removeUserCubit = RemoveUserCubit(mockPersonRepositoryImpl);
        },
      );

      test(
        'Initial state should be RemoveUserState',
        () {
          expect(removeUserCubit.state, const RemoveUserState());
        },
      );

      blocTest<RemoveUserCubit, RemoveUserState>(
        'emits [Loading, Loaded] when RemoveUser is called.',
        build: () {
          when(mockPersonRepositoryImpl.removeUser('')).thenAnswer(
            (_) async => 'The Person has been removed!',
          );
          return removeUserCubit;
        },
        act: (cubit) => cubit.removeUser(''),
        expect: () => [
          const RemoveUserState(
            isLoading: true,
            isSuccess: false,
          ),
          const RemoveUserState(
            isLoading: false,
            isSuccess: true,
            message: 'The Person has been removed!',
          )
        ],
      );

      blocTest<RemoveUserCubit, RemoveUserState>(
        'emits [Loading, Error] when RemoveUser is called.',
        build: () {
          when(mockPersonRepositoryImpl.removeUser('')).thenThrow(
            Exception(),
          );
          return removeUserCubit;
        },
        act: (cubit) => cubit.removeUser(''),
        expect: () => [
          const RemoveUserState(
            isLoading: true,
            isSuccess: false,
          ),
          const RemoveUserState(
            isLoading: false,
            hasError: true,
            message: 'Error has been occurred',
          )
        ],
      );
    },
  );
}

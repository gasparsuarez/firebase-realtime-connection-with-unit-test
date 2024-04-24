// Mocks
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_project/data/repository/person_repository_impl.dart';
import 'package:firebase_project/presentation/cubits/add_user/add_user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<PersonRepositoryImpl>(),
])
import 'add_user_cubit_test.mocks.dart';

void main() {
  group(
    'Add User Cubit',
    () {
      // Arrange
      late AddUserCubit addUserCubit;
      late MockPersonRepositoryImpl mockPersonRepository;

      setUp(() {
        mockPersonRepository = MockPersonRepositoryImpl();
        addUserCubit = AddUserCubit(
          mockPersonRepository,
        );
      });

      tearDown(() {
        addUserCubit.close();
      });

      test('Initial state should be AddUserState', () async {
        expect(addUserCubit.state, const AddUserState());
      });

      blocTest<AddUserCubit, AddUserState>(
        'emits [Loading, Success] when AddUser is called.',
        build: () {
          when(mockPersonRepository.addUser(any)).thenAnswer(
            (_) async => 'User is added!',
          );
          return addUserCubit;
        },
        act: (cubit) => cubit.createUser(),
        expect: () => [
          const AddUserState(
            isLoading: true,
            hasError: false,
            isSuccess: false,
            message: '',
          ),
          const AddUserState(
            isLoading: false,
            isSuccess: true,
            message: 'User is added!',
          ),
        ],
      );

      blocTest<AddUserCubit, AddUserState>(
        'emits [Loading, Error] when AddUser is called.',
        build: () {
          when(mockPersonRepository.addUser(any)).thenThrow(
            Exception('Mock Exception'),
          );
          return addUserCubit;
        },
        act: (cubit) => cubit.createUser(),
        expect: () => [
          const AddUserState(
            isLoading: true,
            hasError: false,
            isSuccess: false,
            message: '',
          ),
          const AddUserState(
            isLoading: false,
            hasError: true,
            message: 'Error has been occurred',
          ),
        ],
      );
    },
  );
}

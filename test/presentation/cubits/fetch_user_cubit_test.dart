import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_project/data/repository/person_repository_impl.dart';
import 'package:firebase_project/domain/entities/person_entity.dart';
import 'package:firebase_project/presentation/cubits/fetch_users/fetch_users_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<PersonRepositoryImpl>()])
import 'add_user_cubit_test.mocks.dart';

void main() {
  group(
    'Fetch User Cubit',
    () {
      late FetchUsersCubit fetchUserCubit;
      late MockPersonRepositoryImpl mockPersonRepositoryImpl;
      late StreamController<List<PersonEntity>> streamController;

      setUp(
        () {
          mockPersonRepositoryImpl = MockPersonRepositoryImpl();
          fetchUserCubit = FetchUsersCubit(
            mockPersonRepositoryImpl,
          );
          streamController = StreamController();
        },
      );

      test(
        'Initial State should be [FetchUserState]',
        () async {
          //Assert
          expect(fetchUserCubit.state, const FetchUsersState());
        },
      );

      blocTest<FetchUsersCubit, FetchUsersState>(
        'emits [Loading] when ListenUsers is called.',
        build: () {
          when(mockPersonRepositoryImpl.fetchAllUsers()).thenAnswer(
            (_) => streamController.stream,
          );
          return fetchUserCubit;
        },
        act: (cubit) => cubit.listenUsers(),
        tearDown: () {
          streamController.close();
        },
        expect: () => [
          const FetchUsersState(
            isLoading: true,
          ),
        ],
      );
    },
  );
}

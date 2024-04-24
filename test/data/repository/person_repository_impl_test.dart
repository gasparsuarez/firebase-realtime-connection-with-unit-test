import 'package:firebase_project/data/repository/person_repository_impl.dart';
import 'package:firebase_project/domain/entities/person_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/person_mock.dart';

@GenerateNiceMocks([MockSpec<PersonRepositoryImpl>()])
import 'person_repository_impl_test.mocks.dart';

void main() {
  group(
    'Person Repository',
    () {
      late MockPersonRepositoryImpl mockPersonRepositoryImpl;

      setUp(
        () {
          mockPersonRepositoryImpl = MockPersonRepositoryImpl();
        },
      );

      test(
        'getUser should be return Stream<PersonEntity>',
        () {
          // Arrange
          when(mockPersonRepositoryImpl.getUser(any)).thenAnswer(
            (_) => Stream.value(person),
          );
          // Act
          final result = mockPersonRepositoryImpl.getUser('');
          // assert
          expect(result, isA<Stream<PersonEntity>>());
        },
      );

      test(
        'addUser should create user and return message',
        () async {
          // Arrange
          when(mockPersonRepositoryImpl.addUser(any)).thenAnswer(
            (_) async => 'User is added!',
          );
          // Act
          final result = await mockPersonRepositoryImpl.addUser(person);
          // assert

          expect(result, 'User is added!');
          expect(result, isA<String>());
        },
      );

      test(
        'addUser should be return Exception',
        () async {
          //Arrange
          when(mockPersonRepositoryImpl.addUser(person)).thenThrow(Exception());

          expect(
            () => mockPersonRepositoryImpl.addUser(person),
            throwsA(isA<Exception>()),
          );
        },
      );

      test(
        'fetchAllUsers should return Stream with user list',
        () async {
          final result = mockPersonRepositoryImpl.fetchAllUsers();
          expect(result, isA<Stream<List<PersonEntity>>>());
        },
      );

      test(
        'removeUser should delete user and return success message',
        () async {
          // arrange
          when(mockPersonRepositoryImpl.removeUser(any)).thenAnswer(
            (_) async => 'The person has been removed!',
          );
          // act
          final result = await mockPersonRepositoryImpl.removeUser('');
          // assert
          expect(result, 'The person has been removed!');
        },
      );

      test(
        'removeUser should return exception',
        () async {
          // arrange
          when(mockPersonRepositoryImpl.removeUser(any)).thenThrow(
            Exception(),
          );

          expect(
            () => mockPersonRepositoryImpl.removeUser(''),
            throwsA(isA<Exception>()),
          );
        },
      );
    },
  );
}

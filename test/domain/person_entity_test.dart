import 'package:firebase_project/domain/entities/person_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Person Entity',
    () {
      test('Should return a valid person', () async {
        //Arrange
        final person = PersonEntity(
          name: 'John',
          lastName: 'Doe',
          age: '18',
        );

        //Assert
        expect(person.name, 'John');
        expect(person.lastName, 'Doe');
        expect(person.age, '18');
        expect(person.uid, null);
      });
    },
  );
}

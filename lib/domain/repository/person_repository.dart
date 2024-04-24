import 'package:firebase_project/domain/entities/person_entity.dart';

abstract class PersonRepository {
  Stream<PersonEntity> getUser(String name);
  Future<String> addUser(PersonEntity person);
  Stream<List<PersonEntity>> fetchAllUsers();
  Future<String> removeUser(String uid);
}

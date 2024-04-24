import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/domain/entities/person_entity.dart';
import 'package:firebase_project/domain/repository/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  ///
  /// Datasource
  ///
  final personRef = FirebaseFirestore.instance.collection('persons').withConverter(
        fromFirestore: (data, _) {
          final user = PersonEntity.fromJson(data.data()!);
          user.uid = data.id;
          return PersonEntity.fromJson(data.data()!);
        },
        toFirestore: (person, _) => person.toJson(),
      );

  @override
  Stream<PersonEntity> getUser(String name) {
    return personRef.where('name', isEqualTo: name).snapshots().map(
      (snapshot) {
        return snapshot.docs.first.data();
      },
    );
  }

  @override
  Future<String> addUser(PersonEntity person) async {
    try {
      await personRef.add(person).then((doc) async {
        await doc.update({'uid': doc.id});
      });
      return 'User is added!';
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<PersonEntity>> fetchAllUsers() {
    return personRef.snapshots().map(
          (e) => e.docs.map((e) => e.data()).toList(),
        );
  }

  @override
  Future<String> removeUser(String uid) async {
    try {
      await personRef.doc(uid).delete();
      return 'The Person has been removed!';
    } catch (e) {
      throw Exception(e);
    }
  }
}

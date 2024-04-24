class PersonEntity {
  String? uid;
  final String name;
  final String lastName;
  final String age;

  PersonEntity({
    this.uid,
    required this.name,
    required this.lastName,
    required this.age,
  });

  factory PersonEntity.fromJson(Map<String, dynamic> json) => PersonEntity(
        name: json['name'],
        lastName: json['lastName'],
        age: json['age'] ?? '',
        uid: json['uid'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'lastName': lastName,
        'age': age,
        'uid': uid,
      };
}

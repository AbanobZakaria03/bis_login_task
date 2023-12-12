class Exercise {
  late final String name;
  late final int count;
  late final String image;
  late final String description;

  Exercise(
      {required this.name,
      required this.count,
      required this.image,
      required this.description});

  Exercise.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    count = map['count'];
    image = map['image'];
    description = map['description'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'count': count,
        'image': image,
        'description': description,
      };
}

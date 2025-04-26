class DogBreed {
  final String name;
  final List<String> subbreeds;

  DogBreed({required this.name, required this.subbreeds});

  factory DogBreed.fromObjBody(String name, List<dynamic> subbreeds) {
    return DogBreed(
      name: name,
      subbreeds: List<String>.from(subbreeds),
    );
  }
}
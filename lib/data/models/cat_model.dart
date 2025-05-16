class Cat {
  final String id;
  final String imageUrl;
  final String breedName;
  final String description;
  final String origin;
  final int affectionLevel;
  final int energyLevel;
  final int grooming;
  final String wikipediaUrl;
  final DateTime? likedAt;

  Cat({
    required this.id,
    required this.imageUrl,
    required this.breedName,
    required this.description,
    required this.origin,
    required this.affectionLevel,
    required this.energyLevel,
    required this.grooming,
    required this.wikipediaUrl,
    this.likedAt,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    final breeds = (json['breeds'] as List?) ?? [];
    final breed = breeds.isNotEmpty ? breeds[0] : null;

    return Cat(
      id: json['id'] ?? 'unknown',
      imageUrl: json['url'] ?? '',
      breedName: breed?['name'] ?? 'Без породы',
      description: breed?['description'] ?? 'Описание отсутствует',
      origin: breed?['origin'] ?? 'Неизвестно',
      affectionLevel: breed?['affection_level'] ?? 0,
      energyLevel: breed?['energy_level'] ?? 0,
      grooming: breed?['grooming'] ?? 0,
      wikipediaUrl: breed?['wikipedia_url'] ?? '',
    );
  }

  Cat copyWith({DateTime? likedAt}) {
    return Cat(
      id: id,
      imageUrl: imageUrl,
      breedName: breedName,
      description: description,
      origin: origin,
      affectionLevel: affectionLevel,
      energyLevel: energyLevel,
      grooming: grooming,
      wikipediaUrl: wikipediaUrl,
      likedAt: likedAt ?? this.likedAt,
    );
  }
}

import '../../../data/models/cat_model.dart';

class LikedCatsState {
  final List<Cat> likedCats;
  final String filter;

  LikedCatsState({required this.likedCats, this.filter = ''});

  List<Cat> get filteredCats =>
      filter.trim().isEmpty
          ? likedCats
          : likedCats
              .where(
                (cat) => cat.breedName.toLowerCase().contains(
                  filter.toLowerCase().trim(),
                ),
              )
              .toList();

  LikedCatsState copyWith({List<Cat>? likedCats, String? filter}) {
    return LikedCatsState(
      likedCats: likedCats ?? this.likedCats,
      filter: filter ?? this.filter,
    );
  }
}

import '../../../data/models/cat_model.dart';

abstract class LikedCatsEvent {}

class AddLikedCat extends LikedCatsEvent {
  final Cat cat;
  AddLikedCat(this.cat);
}

class RemoveLikedCat extends LikedCatsEvent {
  final String catId;
  RemoveLikedCat(this.catId);
}

class FilterLikedCats extends LikedCatsEvent {
  final String breed;
  FilterLikedCats(this.breed);
}

import '../../data/models/cat_model.dart';

abstract class CatRepository {
  Future<Cat?> fetchRandomCat();
}

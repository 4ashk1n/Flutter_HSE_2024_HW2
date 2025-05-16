import 'package:dio/dio.dart';
import '../models/cat_model.dart';
import '../../domain/repositories/cat_repository.dart';

class CatApiService implements CatRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.thecatapi.com/v1/images/search';
  final String _apiKey =
      'live_PCbz9tLPPB7LflJsWeKRi3B86eBFdT0I9POlMRzUIq03SUkEVSMsz4Ihc9wZ2oBy';

  @override
  Future<Cat?> fetchRandomCat() async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'has_breeds': 1},
        options: Options(headers: {'x-api-key': _apiKey}),
      );

      if (response.data is List && response.data.isNotEmpty) {
        return Cat.fromJson(response.data[0]);
      }
    } catch (e) {
      throw 'Failed to fetch random cat: $e';
    }
    return null;
  }
}

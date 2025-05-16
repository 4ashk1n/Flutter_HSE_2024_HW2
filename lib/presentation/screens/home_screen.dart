import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/cat_model.dart';
import '../../domain/repositories/cat_repository.dart';
import '../../di/locator.dart';
import '../blocs/liked_cats/liked_cats_bloc.dart';
import '../blocs/liked_cats/liked_cats_event.dart';
import '../screens/details_screen.dart';
import '../screens/liked_cats_screen.dart';
import '../widgets/like_dislike_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CatRepository _repo = locator<CatRepository>();
  Cat? currentCat;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNewCat();
  }

  Future<void> _fetchNewCat() async {
    setState(() => isLoading = true);
    try {
      final cat = await _repo.fetchRandomCat();
      setState(() {
        currentCat = cat;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text('Ошибка загрузки'),
                content: Text(
                  e.toString().contains('SocketException')
                      ? 'Нет подключения к интернету.'
                      : 'Что-то пошло не так: $e',
                ),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
        );
      }
    }
  }

  void _onLike() {
    if (currentCat != null) {
      final likedCat = currentCat!.copyWith(likedAt: DateTime.now());
      context.read<LikedCatsBloc>().add(AddLikedCat(likedCat));
    }
    _fetchNewCat();
  }

  void _onDislike() => _fetchNewCat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кототиндер'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => BlocProvider.value(
                          value: context.read<LikedCatsBloc>(),
                          child: const LikedCatsScreen(),
                        ),
                  ),
                ),
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : currentCat == null
              ? const Center(child: Text('Ошибка загрузки кота'))
              : GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    _onLike();
                  } else if (details.primaryVelocity! < 0) {
                    _onDislike();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsScreen(cat: currentCat!),
                            ),
                          ),
                      child: CachedNetworkImage(
                        imageUrl: currentCat!.imageUrl,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                        placeholder:
                            (_, __) => const CircularProgressIndicator(),
                        errorWidget: (_, __, ___) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentCat!.breedName,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    LikeDislikeButtons(onLike: _onLike, onDislike: _onDislike),
                  ],
                ),
              ),
    );
  }
}

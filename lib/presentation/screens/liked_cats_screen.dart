import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/liked_cats/liked_cats_bloc.dart';
import '../blocs/liked_cats/liked_cats_event.dart';
import '../blocs/liked_cats/liked_cats_state.dart';
import '../widgets/cat_card.dart';

class LikedCatsScreen extends StatelessWidget {
  const LikedCatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liked Cats')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Filter by breed',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<LikedCatsBloc>().add(FilterLikedCats(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<LikedCatsBloc, LikedCatsState>(
              builder: (context, state) {
                if (state.filteredCats.isEmpty) {
                  return const Center(child: Text('No liked cats.'));
                }
                return ListView.builder(
                  itemCount: state.filteredCats.length,
                  itemBuilder: (context, index) {
                    final cat = state.filteredCats[index];
                    return CatCard(
                      cat: cat,
                      onRemove: () {
                        context.read<LikedCatsBloc>().add(
                          RemoveLikedCat(cat.id),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

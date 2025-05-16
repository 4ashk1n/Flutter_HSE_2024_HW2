import 'package:flutter/material.dart';
import '../../data/models/cat_model.dart';

class CatCard extends StatelessWidget {
  final Cat cat;
  final VoidCallback onRemove;

  const CatCard({super.key, required this.cat, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          cat.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(cat.breedName),
        subtitle: Text(
          cat.likedAt != null
              ? 'Liked at: ${cat.likedAt!.toLocal().toIso8601String()}'
              : '',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onRemove,
        ),
      ),
    );
  }
}

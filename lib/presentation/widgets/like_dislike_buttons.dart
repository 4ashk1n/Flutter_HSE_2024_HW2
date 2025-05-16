import 'package:flutter/material.dart';

class LikeDislikeButtons extends StatelessWidget {
  final VoidCallback onLike;
  final VoidCallback onDislike;

  const LikeDislikeButtons({
    super.key,
    required this.onLike,
    required this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.thumb_down, color: Colors.red, size: 40),
          onPressed: onDislike,
        ),
        SizedBox(width: 20),
        IconButton(
          icon: Icon(Icons.thumb_up, color: Colors.green, size: 40),
          onPressed: onLike,
        ),
      ],
    );
  }
}

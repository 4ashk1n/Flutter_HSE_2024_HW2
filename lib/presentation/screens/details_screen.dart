import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/cat_model.dart';

class DetailsScreen extends StatelessWidget {
  final Cat cat;
  const DetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cat.breedName)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: cat.imageUrl,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cat.breedName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    cat.description,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "🌍 Страна происхождения: ${cat.origin}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "❤️ Дружелюбность: ${cat.affectionLevel}/5",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "🎮 Энергичность: ${cat.energyLevel}/5",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "🧼 Уровень ухода: ${cat.grooming}/5",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  if (cat.wikipediaUrl.isNotEmpty)
                    TextButton(
                      onPressed: () => _openWikipedia(cat.wikipediaUrl),
                      child: Text(
                        "📖 Подробнее на Wikipedia",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openWikipedia(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}

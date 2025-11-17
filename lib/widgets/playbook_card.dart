import 'package:flutter/material.dart';

class PlaybookCard extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  PlaybookCard({required this.id, required this.title, this.subtitle = '', this.isFavorite = false, this.onTap, this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(isFavorite ? Icons.star : Icons.star_border, color: isFavorite ? Colors.amber : null),
              onPressed: onFavoriteToggle,
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

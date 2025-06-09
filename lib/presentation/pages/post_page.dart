import 'package:crowd_counting_app/core/constants/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const PostPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Sukses')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Judul: ${data['title']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Konten: ${data['content']}'),
            SizedBox(height: 8),
            Text('Count: ${data['count']}'),
            SizedBox(height: 16),
            Text('Gambar:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            CachedNetworkImage(
              imageUrl: '${ApiEndpoints.baseUrl}/${data['image']}',
              height: 200,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 16),
            Text('Heatmap:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            CachedNetworkImage(
              imageUrl: '${ApiEndpoints.baseUrl}/${data['heatmap']}',
              height: 200,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}
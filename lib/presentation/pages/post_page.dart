import 'package:crowd_counting_app/core/constants/api_endpoints.dart';
import 'package:crowd_counting_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const PostPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text("Detail Post"), backgroundColor: AppColors.primary, foregroundColor: AppColors.background, centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: '${ApiEndpoints.baseUrl}/${data['image']}',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => Container(
                height: 200,
                color: Colors.grey[300],
              ),
              errorWidget: (context, url, error) => Icon(Icons.broken_image),
            ),
            const SizedBox(height: 12),
            Text("Heatmap",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 12),
            CachedNetworkImage(
              imageUrl: '${ApiEndpoints.baseUrl}/${data['heatmap']}',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => Container(
                height: 200,
                color: Colors.grey[300],
              ),
              errorWidget: (context, url, error) => Icon(Icons.broken_image),
            ),
            const SizedBox(height: 20),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Post ID: #${data['id']}", style: TextStyle(color: Colors.grey[600])),
                Text("Estimasi: ${data['count']} orang", style: TextStyle(fontWeight: FontWeight.w600))
              ],
            )
          ],
        ),
      ),
    );
  }
}
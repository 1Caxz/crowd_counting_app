import 'package:flutter/material.dart';

class PagePlaceholder extends StatelessWidget {
  final String title;
  const PagePlaceholder({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Memuat $title...', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
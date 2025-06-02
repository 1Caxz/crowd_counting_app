import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.photo),
        title: Text('Content Item #$index'),
      ),
    );
  }
}

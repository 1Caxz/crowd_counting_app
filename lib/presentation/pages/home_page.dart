import 'package:crowd_counting_app/core/constants/api_endpoints.dart';
import 'package:crowd_counting_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'post_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _items = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_isLoading && _hasMore) {
        _fetchData();
      }
    });
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    final response = await http.get(Uri.parse('${ApiEndpoints.postList}?page=$_page'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newItems = data['data'];
      setState(() {
        _page++;
        _items.addAll(newItems);
        if (newItems.isEmpty) _hasMore = false;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: _items.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _items.length) {
            return Center(child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ));
          }
          final item = _items[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PostPage(data: item)),
            ),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: '${ApiEndpoints.baseUrl}/${item['image']}',
                          height: 180,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 180,
                            color: Colors.grey[300],
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.broken_image),
                        ),
                      ),
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: '${ApiEndpoints.baseUrl}/${item['heatmap']}',
                          height: 180,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 180,
                            color: Colors.grey[300],
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.broken_image),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Estimasi: ${item['count']} orang",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
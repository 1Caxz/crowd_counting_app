
import 'dart:convert';
import 'dart:io';
import 'package:crowd_counting_app/core/constants/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'post_page.dart';

class CameraUploadPage extends StatefulWidget {
  @override
  _CameraUploadPageState createState() => _CameraUploadPageState();
}

class _CameraUploadPageState extends State<CameraUploadPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage(_image!);
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final uri = Uri.parse(ApiEndpoints.postCreate);
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['title'] = 'Contoh Judul';
    request.fields['content'] = 'Deskripsi konten crowd counting';

    final fileName = path.basename(imageFile.path);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path, filename: fileName));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final postData = json['data'];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PostPage(data: postData)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal upload gambar.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _image == null
              ? Center(child: Text('Belum ada gambar.'))
              : Container(
                  width: double.infinity,
                  child: Image.file(_image!, fit: BoxFit.fitWidth),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text('Live Counting'),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text('Image Counting'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
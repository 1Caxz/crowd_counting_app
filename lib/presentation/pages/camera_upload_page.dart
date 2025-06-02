import 'package:flutter/material.dart';

class CameraUploadPage extends StatelessWidget {
  const CameraUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt, size: 100),
          SizedBox(height: 16),
          Text('Upload an image using the camera.'),
          ElevatedButton(
            onPressed: () {
              // camera upload logic
            },
            child: Text('Open Camera'),
          ),
        ],
      ),
    );
  }
}

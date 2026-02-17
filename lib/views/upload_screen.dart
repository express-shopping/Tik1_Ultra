import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UploadScreen extends StatefulWidget {
  final File videoFile;
  const UploadScreen({super.key, required this.videoFile});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(isArabic ? "معاينة الفيديو" : "Video Preview"),
        actions: [
          TextButton(
            onPressed: () => print("تم النشر"),
            child: Text(isArabic ? "نشر" : "Post", style: const TextStyle(color: Colors.pinkAccent, fontSize: 18)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _controller.value.isInitialized
                ? Center(child: AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)))
                : const Center(child: CircularProgressIndicator()),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                hintText: isArabic ? "اكتب وصفاً..." : "Write a caption...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


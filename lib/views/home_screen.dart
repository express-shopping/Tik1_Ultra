import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_screen.dart';
import 'upload_screen.dart';
import 'settings_screen.dart';
import '../widgets/video_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  Future<void> _pickVideo() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => UploadScreen(videoFile: File(video.path))));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final List<Widget> pages = [
      const HomeContent(),
      const Center(child: Text("Discover")),
      const SizedBox(),
      const Center(child: Text("Messages")),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _pageIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white,
        currentIndex: _pageIndex,
        onTap: (index) => index == 2 ? _pickVideo() : setState(() => _pageIndex = index),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: isArabic ? 'الرئيسية' : 'Home'),
          BottomNavigationBarItem(icon: const Icon(Icons.search), label: isArabic ? 'اكتشف' : 'Discover'),
          const BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 40), label: ''),
          BottomNavigationBarItem(icon: const Icon(Icons.message), label: isArabic ? 'البريد' : 'Inbox'),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: isArabic ? 'الملف' : 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 2,
      itemBuilder: (context, index) => VideoCard(videoUrl: "https://v1.mixkit.co/videos/preview/mixkit-dance-in-neon-lights-1230-large.mp4"),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const Tik1App());

class Tik1App extends StatelessWidget {
  const Tik1App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tik1 Ultra',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [HomeFeed(), Center(child: Text("Discover")), SizedBox(), Center(child: Text("Inbox")), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFF00F2EA),
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (i) => i == 2 ? _pickVideo() : setState(() => _selectedIndex = i),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_filled), label: isAr ? 'الرئيسية' : 'Home'),
          BottomNavigationBarItem(icon: const Icon(Icons.explore_outlined), label: isAr ? 'اكتشف' : 'Discover'),
          BottomNavigationBarItem(icon: _buildAddButton(), label: ''),
          BottomNavigationBarItem(icon: const Icon(Icons.chat_bubble_outline), label: isAr ? 'البريد' : 'Inbox'),
          BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: isAr ? 'الملف' : 'Profile'),
        ],
      ),
    );
  }

  Widget _buildAddButton() => Container(
    width: 45, height: 30,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), gradient: const LinearGradient(colors: [Color(0xFF00F2EA), Color(0xFFFF0050)])),
    child: const Icon(Icons.add, color: Colors.black),
  );

  void _pickVideo() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Selected: ${video.name}")));
    }
  }
}

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});
  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, colors: [Color(0xFF1a1a1a), Colors.black])),
            child: const Center(child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white10)),
          ),
          _buildSideActions(), // الأزرار الآن في اليسار
          _buildVideoCaptions(),
        ],
      ),
    );
  }

  Widget _buildSideActions() => Positioned(
    bottom: 100, left: 10, // تم النقل لليسار كما طلبت
    child: Column(
      children: [
        _profileWithPlus(),
        const SizedBox(height: 20),
        _actionIcon(Icons.favorite, isLiked ? "1.3M" : "1.2M", isLiked ? Colors.red : Colors.white, () {
          setState(() => isLiked = !isLiked);
        }),
        _actionIcon(Icons.comment, "45k", Colors.white, () {}),
        _actionIcon(Icons.bookmark, "12k", Colors.white, () {}),
        _actionIcon(Icons.share, "Share", Colors.white, () {}),
      ],
    ),
  );

  Widget _profileWithPlus() => InkWell(
    onTap: () => print("Profile Clicked"),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const CircleAvatar(radius: 25, backgroundColor: Colors.grey, child: Icon(Icons.person, color: Colors.white))),
        Positioned(bottom: 0, child: Container(decoration: const BoxDecoration(color: Color(0xFFFF0050), shape: BoxShape.circle), child: const Icon(Icons.add, size: 18, color: Colors.white))),
      ],
    ),
  );

  Widget _actionIcon(IconData icon, String label, Color col, VoidCallback onTap) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: InkWell(
      onTap: onTap,
      child: Column(children: [Icon(icon, size: 38, color: col), Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))]),
    ),
  );

  Widget _buildVideoCaptions() => Positioned(
    bottom: 25, right: 15, left: 80, // عكسنا الجهات لتتناسب مع وجود الأزرار في اليسار
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("@Golden_Dev", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        SizedBox(height: 10),
        Text("تطبيق Tik1 Ultra بنسخة الأزرار اليسرى 🚀✨", style: TextStyle(fontSize: 15, color: Colors.white)),
        SizedBox(height: 10),
        Row(children: [Icon(Icons.music_note, size: 15), Text(" الصوت الأصلي - المطور الذهبي", style: TextStyle(fontSize: 13))]),
      ],
    ),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    bool isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, elevation: 0, title: const Text("Golden Dev"), centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.wallet, color: Colors.amber), onPressed: () {
          // محاكاة سحب الأرباح
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("رصيدك الحالي: 150.50\$ - السحب متاح عند الوصول لـ 200\$")));
        })],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 50, backgroundColor: Colors.blueAccent, child: Icon(Icons.person, size: 50, color: Colors.white)),
          const SizedBox(height: 15),
          const Text("@Golden_Dev", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("💰 الرصيد: 150.50\$", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _stat("128", isAr ? "متابعة" : "Following"),
              _divider(),
              _stat("15.4k", isAr ? "متابعين" : "Followers"),
              _divider(),
              _stat("200k", isAr ? "تسجيلات" : "Likes"),
            ],
          ),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _btn(isAr ? "تعديل" : "Edit", Colors.white12, () {}), 
            const SizedBox(width: 5), 
            _btn(isAr ? "مشاركة" : "Share", Colors.white12, () {})
          ]),
          const SizedBox(height: 20),
          const Divider(color: Colors.white12),
          Expanded(child: GridView.builder(itemCount: 9, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.7, crossAxisSpacing: 2, mainAxisSpacing: 2), itemBuilder: (c, i) => Container(color: Colors.white10, child: const Icon(Icons.play_arrow, color: Colors.white24)))),
        ],
      ),
    );
  }
  Widget _stat(String v, String l) => Column(children: [Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text(l, style: const TextStyle(color: Colors.white54, fontSize: 13))]);
  Widget _divider() => Container(height: 15, width: 1, color: Colors.white24, margin: const EdgeInsets.symmetric(horizontal: 20));
  Widget _btn(String t, Color c, VoidCallback action) => InkWell(
    onTap: action,
    child: Container(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(4)), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold))),
  );
}

// صفحة الإعدادات بقيت كما هي لضمان استقرار التطبيق
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    bool isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      appBar: AppBar(title: Text(isAr ? "الإعدادات والخصوصية" : "Settings & Privacy"), backgroundColor: Colors.black),
      body: ListView(
        children: [
          _sec(isAr ? "الحساب" : "Account"),
          _tile(Icons.person, isAr ? "إدارة الحساب" : "Manage Account", () {}),
          _tile(Icons.lock, isAr ? "الخصوصية" : "Privacy", () {}),
          _sec(isAr ? "المحتوى" : "Content"),
          _tile(Icons.language, isAr ? "اللغة" : "Language", () {}),
          _tile(Icons.dark_mode, isAr ? "الوضع الداكن" : "Dark Mode", () {}),
          _sec(isAr ? "الدعم" : "Support"),
          _tile(Icons.help, isAr ? "مركز المساعدة" : "Help Center", () {}),
          const SizedBox(height: 20),
          InkWell(onTap: () {}, child: Center(child: Text(isAr ? "تسجيل الخروج" : "Log Out", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }
  Widget _sec(String t) => Padding(padding: const EdgeInsets.all(15), child: Text(t, style: const TextStyle(color: Colors.white54, fontSize: 13)));
  Widget _tile(IconData i, String t, VoidCallback tap) => ListTile(leading: Icon(i), title: Text(t), trailing: const Icon(Icons.arrow_forward_ios, size: 14), onTap: tap);
}


import 'package:flutter/material.dart';
import 'settings_screen.dart'; // استدعاء صفحة الإعدادات

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // التحقق من لغة الهاتف لعرض النصوص بشكل صحيح
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        // عنوان الصفحة يتغير حسب اللغة
        title: Text(
          isArabic ? 'الملف الشخصي' : 'Profile',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // أيقونة الإعدادات (تفتح صفحة الإعدادات بلمسة واحدة)
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // صورة الملف الشخصي مع تأثير هالة النيون
          Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.pinkAccent, Colors.blueAccent]),
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text('@Golden_Dev', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          
          // إحصائيات الحساب
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStat(isArabic ? "متابعة" : "Following", "128"),
              _buildDivider(),
              _buildStat(isArabic ? "متابعين" : "Followers", "15.4k"),
              _buildDivider(),
              _buildStat(isArabic ? "إعجاب" : "Likes", "200k"),
            ],
          ),
          const SizedBox(height: 25),
          
          // أزرار التحكم بتصميم راقي
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(isArabic ? "تعديل الملف" : "Edit Profile", Colors.white10, Colors.white),
              const SizedBox(width: 10),
              _buildActionButton(isArabic ? "مشاركة" : "Share", Colors.pinkAccent, Colors.white),
            ],
          ),
          const SizedBox(height: 30),
          
          // منطقة عرض الفيديوهات (Grid View)
          const Divider(color: Colors.white24, thickness: 0.5),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2/3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  image: DecorationImage(
                    image: NetworkImage('https://picsum.photos/200/300?random=$index'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(Icons.play_arrow_outlined, color: Colors.white, size: 15),
                        Text('1.2M', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ودجت فرعية للإحصائيات
  Widget _buildStat(String label, String count) {
    return Column(
      children: [
        Text(count, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
      ],
    );
  }

  Widget _buildDivider() => Container(height: 20, width: 1, color: Colors.white24, margin: const EdgeInsets.symmetric(horizontal: 20));

  Widget _buildActionButton(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(5)),
      child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }
}


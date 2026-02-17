import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? "الإعدادات والخصوصية" : "Settings & Privacy"),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          _buildSection(isArabic ? "الحساب" : "Account"),
          _buildTile(Icons.person_outline, isArabic ? "إدارة الحساب" : "Manage Account"),
          _buildTile(Icons.lock_outline, isArabic ? "الخصوصية" : "Privacy"),
          _buildSection(isArabic ? "المحتوى" : "Content"),
          _buildTile(Icons.language, isArabic ? "لغة التطبيق" : "App Language"),
          _buildTile(Icons.dark_mode_outlined, isArabic ? "الوضع الليلي" : "Dark Mode"),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(isArabic ? "تسجيل الخروج" : "Log Out", style: const TextStyle(color: Colors.redAccent)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSection(String title) => Padding(
    padding: const EdgeInsets.all(15),
    child: Text(title, style: const TextStyle(color: Colors.white54, fontSize: 14)),
  );

  Widget _buildTile(IconData icon, String title) => ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(title, style: const TextStyle(color: Colors.white)),
    trailing: const Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white24),
  );
}


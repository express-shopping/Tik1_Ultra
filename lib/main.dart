import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      // سنبدأ بصفحة تسجيل الدخول أولاً
      home: const LoginPage(), 
    );
  }
}

// --- صفحة تسجيل الدخول الجديدة ---
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.music_video, size: 100, color: Color(0xFF00F2EA)),
            const SizedBox(height: 20),
            const Text("التسجيل في Tik1 Ultra", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            
            _loginButton(Icons.person_outline, "استخدام الهاتف أو البريد", () {
              // سننتقل للتطبيق مباشرة مؤقتاً لنريك الواجهة
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
            }),
            const SizedBox(height: 15),
            _loginButton(Icons.g_mobiledata, "المتابعة باستخدام Google", () {}),
            const SizedBox(height: 15),
            _loginButton(Icons.facebook, "المتابعة باستخدام Facebook", () {}),
            
            const SizedBox(height: 50),
            const Text("بالاستمرار أنت توافق على شروط الخدمة", style: TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Icon(icon, size: 25),
            Expanded(child: Center(child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)))),
          ],
        ),
      ),
    );
  }
}

// (بقية الكود الخاص بـ MainScreen و HomeFeed يبقى كما هو في الأسفل...)
// ملاحظة: تأكد من إلحاق كود MainScreen و HomeFeed و ProfilePage الذي أعطيتك إياه سابقاً هنا.


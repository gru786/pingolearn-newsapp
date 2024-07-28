import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_news/authentication/presentation/login_screen.dart';
import 'package:my_news/authentication/providers/auth_helper.dart';
import 'package:my_news/authentication/providers/auth_provider.dart';
import 'package:my_news/firebase_options.dart';
import 'package:my_news/global/global_colors.dart';
import 'package:my_news/home/presentation/home_screen.dart';
import 'package:my_news/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationHelper authenticationHelper = AuthenticationHelper();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My News',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor, primary: kPrimaryColor, secondary: kSecondaryColor,),
            useMaterial3: true,
          ),
          home: authenticationHelper.user == null ? const LoginScreen() :const HomeScreen(),
        ),
      ),
    );
  }
}

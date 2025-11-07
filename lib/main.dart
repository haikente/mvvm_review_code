import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_review/firebase_options.dart';
import 'package:mvvm_review/repositories/auth_repositories.dart';
import 'package:mvvm_review/splash.dart';
import 'package:mvvm_review/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Khởi tạo Firebase

  runApp(
    MultiProvider(providers: [
      Provider<AuthRepositories>(
        create: (_) => AuthRepositories(),
      ),

      ChangeNotifierProvider<LoginViewmodel>(
        create: (context) => LoginViewmodel(
            context.read<AuthRepositories>(),
        ),
      ),

    ], child: const MyApp()),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: const ColorScheme.dark(
           primary: Color(0xFF13A4EC),
          background: Color(0xFF101C22),
        )
        
      ),
      home: const Splash(),
    );
  }
}

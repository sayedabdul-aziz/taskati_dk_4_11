import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati_dk_4_11/core/utils/colors.dart';
import 'package:taskati_dk_4_11/core/utils/styles.dart';
import 'package:taskati_dk_4_11/feature/home/model/task_model.dart';
import 'package:taskati_dk_4_11/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('user');
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('task');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.lightBg,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: AppColors.primaryColor),
            actionsIconTheme: IconThemeData(color: AppColors.primaryColor),
            titleTextStyle: getTitleStyle(color: AppColors.primaryColor),
            centerTitle: true,
            backgroundColor: AppColors.lightBg,
            elevation: 0.0),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.primaryColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.redColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.redColor)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}

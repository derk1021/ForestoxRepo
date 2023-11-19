import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/screens/auth/login/view/login_screen.dart';
import 'package:tonyyaooo/utils/text_styles/text_styles.dart';
import 'package:tonyyaooo/utils/theme/theme_data.dart';
import 'bindings/initializing_dependency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'service/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        alignment: Alignment.center,
        child: Text(
          'Error!\n${details.exception}',
          style: CustomTextStyles.black520,
          textAlign: TextAlign.center,
        ),
      ),
    );
  };
  runApp(
    const TonyyaooApp(),
  );
}

class TonyyaooApp extends StatelessWidget {
  const TonyyaooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        initialBinding: InitializingDependency(),
        debugShowCheckedModeBanner: false,
        title: 'Tonyyaoo',
        theme: CustomThemeData.lightViewTheme,
        home: const LogInScreen(),
      ),
    );
  }
}

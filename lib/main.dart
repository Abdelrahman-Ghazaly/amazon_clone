import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/ui/screens.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Amazon Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: kBackgroundColor,
        ),
        home: StreamBuilder(
          stream: Authentication().firebaseAuth.authStateChanges(),
          builder: (context, AsyncSnapshot<fb.User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            } else if (user.hasData) {
              return const SafeArea(child: Scaffold(body: ScreenLayout()));
            } else {
              return const SafeArea(
                child: Scaffold(body: SignInScreen()),
              );
            }
          },
        ),
      ),
    );
  }
}

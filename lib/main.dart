import 'package:fe_assign/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/wallet_provider.dart';
import 'view/screen/login_screen.dart';
import 'di_container.dart' as di;



final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => di.sl<LoginProvider>()),
      ChangeNotifierProvider(create: (_) => di.sl<WalletProvider>())
    ],
    child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

/*class Get {
  static BuildContext? get context => navigatorKey.currentContext;

}*/



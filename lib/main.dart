import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'levels/levels_list.dart';
import 'login_sign_up/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool auth;
  if(prefs.get("auth") == null){
    runApp(
        const MyApp(auth: false,)
    );
  }else{
    auth = prefs.getBool("auth") ?? true;
    runApp(
        MyApp(auth: auth,)
    );
  }

}

class MyApp extends StatelessWidget {
  final bool auth;
  const MyApp({Key? key, required this.auth}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.deepOrange),
      ),
      home:  auth ? const Levels() : const Login(),
    );
  }
}

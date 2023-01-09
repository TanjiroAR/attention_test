import 'package:attention_test/levels/levels_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/levels_data.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                        const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0, 1])),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 94),
                      child: Image.asset(
                        'assets/ic.png',
                        height: 100,
                        width: 100,
                      ),
                    )),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: const AuthCard(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

enum AuthMode { login, signup }

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'userName': "",
    'password': "",
  };
  bool _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  SqlDb sqlDb = SqlDb();
  updateData(int level) async {
    await sqlDb.updateData(
        "UPDATE 'data' SET tofa = 0,toca = 0,time = 0, nerrors = 0, answer = 'لا', note = ''  WHERE level = $level");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 300,
        ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
      _controller.reverse();
    }
  }

  void _submit() async {
    final prefs = await SharedPreferences.getInstance();
    var user = prefs.getString("name");
    var pass = prefs.getString("pass");
    if (user == null) {
      _showErrorDialog("! يجب انشاء حساب جديد");
    } else if (user == _authData["userName"]! &&
        pass == _authData["password"]!) {
      prefs.setBool("auth", true);
      Get.off(const Levels());
    } else if (user != _authData["userName"]!) {
      _showErrorDialog("! اسم المستخدم غير صحيح");
    } else if (pass != _authData["password"]!) {
      _showErrorDialog("! كلمة المرور غير صحيحة");
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.signup ? 320 : 260,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.signup ? 320 : 260,
        ),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'اسم المستخدم'),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '! يجب ادخال اسم';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authData["userName"] = val!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'كلمة المرور'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (val) {
                    if (val!.isEmpty || val.length < 4) {
                      return '! كلمة المرور قصيرة جدا';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authData["password"] = val!;
                  },
                ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.signup ? 60 : 0,
                      maxHeight: _authMode == AuthMode.signup ? 120 : 0),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _authMode == AuthMode.signup
                          ? TextFormField(
                              enabled: _authMode == AuthMode.signup,
                              decoration: const InputDecoration(
                                  labelText: 'تأكيد كلمة المرور'),
                              obscureText: true,
                              validator: _authMode == AuthMode.signup
                                  ? (val) {
                                      if (val != _passwordController.text) {
                                        return '! كلمة المرور غير مطابقة';
                                      }
                                      return null;
                                    }
                                  : null,
                              onSaved: (val) {
                                _authData["password"] = val!;
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading) const CircularProgressIndicator(),
                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    _formKey.currentState!.save();
                    setState(() {
                      _isLoading = true;
                    });
                    final prefs =
                        await SharedPreferences.getInstance();
                    if (_authMode == AuthMode.signup) {
                      prefs.setString("name", _authData["userName"]!);
                      prefs.setString("pass", _authData["password"]!);
                      prefs.setBool("auth", true);
                      Get.off(const Levels());
                      setState(() {
                        updateData(1);
                        updateData(2);
                        updateData(3);
                        updateData(4);
                        updateData(5);
                        updateData(6);
                        updateData(7);
                        updateData(8);
                        updateData(9);
                        updateData(10);
                      });
                    } else if (_authMode == AuthMode.login) {
                      _submit();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  ),
                  child: Text(_authMode == AuthMode.login
                      ? 'تسجيل دخول'
                      : 'انشاء حساب'),
                ),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(_authMode == AuthMode.login
                      ? 'انشاء حساب'
                      : 'تسجيل دخول'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String massage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('! خطأ في التسجيل'),
              content: Text(massage),
              actions: [
                Center(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  ),
                  child: const Text('! حسنا'),
                ))
              ],
            ));
  }
}

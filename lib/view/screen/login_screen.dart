
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/login_provider.dart';
import '../../utils/app_constants.dart';
import '../base/custom_snackbar.dart';
import 'wallet_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    final LoginProvider loginProvider =  Provider.of<LoginProvider>(context, listen: false);
    loginProvider.setIsLoading = false;
  }

  void _login(LoginProvider loginProvider) async {
    if (_usernameController?.text == AppConstants.constUser) {
      String email = _usernameController!.text.trim();
      String password = _passwordController!.text.trim();
      if (password.isEmpty) {
        showCustomSnackBar('enter_password',context,true);
      }else if (password.length < 6) {
        showCustomSnackBar('password should be more than 6 char.',context,true);
      }else{
        await loginProvider.fetchUsers(email).then((status) async {
          if(status){
            showCustomSnackBar('Success.',context,false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WalletScreen()),
            );
          }else{
            showCustomSnackBar('Error in response.',context,true);
          }

        });
      }
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Login Failed"),
          content: Text("Invalid username or password."),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("OK"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  child: Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) => Form(
                      key: _formKeyLogin,
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(labelText: "Username"),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password"),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(onPressed: ()=> _login(loginProvider), child: Text("Login")),
                      ],
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

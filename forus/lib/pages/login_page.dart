import 'package:forus/const.dart';
import 'package:forus/services/alert_service.dart';
import 'package:forus/services/auth_services.dart';
import 'package:forus/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forus/widgets/custom_form_field.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _logiFormKey = GlobalKey();
  final GetIt _getIt = GetIt.instance;
  late AuthServices _authServices;
  late NavigationService _navigationService;
  late AlertService _alertService;

  String? email, password;

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              _headerText(),
              _loginForm(),
              _createAnAccountLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi welcome Back",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "Hello again you have been missed ",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.of(context).size.height *
          0.6, // Adjust height to control spacing
      child: Form(
        key: _logiFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomFormField(
              hintText: "E-mail",
              height: MediaQuery.of(context).size.height * 0.1,
              validationRegExp: EMAIL_VALIDATION_REGEX,
              obscureText: false,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(height: 20), // Add some space between fields
            CustomFormField(
              height: MediaQuery.of(context).size.height * 0.1,
              hintText: "Password",
              validationRegExp: PASSWORD_VALIDATION_REGEX,
              obscureText: true,
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.primary,
        child: const Text("Login",
            style: TextStyle(
              color: Colors.white,
            )),
        onPressed: () async {
          if (_logiFormKey.currentState?.validate() ?? false) {
            _logiFormKey.currentState?.save();
            bool result = await _authServices.login(email!, password!);
            print(result);
            if (result) {
              _alertService.showToast(
                  text: "Login Successfull", icon: Icons.check);
              _navigationService.pushReplacementNamed("/home");
            } else {
              _alertService.showToast(
                  text: "Failed to Login Please try again", icon: Icons.error);
            }
          }
        },
      ),
    );
  }

  Widget _createAnAccountLink() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Don't have an Account? "),
          GestureDetector(
            onTap: () {
              _navigationService.pushNamed("/register");
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

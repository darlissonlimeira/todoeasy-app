import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_easy/components/input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/logo.svg",
                      width: 85,
                      height: 100,
                    ),
                    const Text(
                      "Welcome to TodoEasy!",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    _formLogin(),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Registrar-se",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool("noAccount", true);
                    }();
                    context.go('/home');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Entrar sem uma conta",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(CupertinoIcons.chevron_forward,
                          color: Color.fromARGB(255, 128, 109, 252)),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Column _formLogin() {
    return Column(
      children: [
        const InputField(
          labelText: "Email",
          hintText: "Digite seu email",
          hiddenText: false,
        ),
        const SizedBox(
          height: 15,
        ),
        const InputField(
          labelText: "Senha",
          hintText: "Digite sua senha",
          hiddenText: true,
        ),
        const SizedBox(
          height: 30,
        ),
        FilledButton(
            child: const Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login_rounded,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Entrar",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            onPressed: () {})
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:w/screen/login2.dart';
import 'package:w/screen/signUp_screen.dart';

import '../widget/components.dart';
class loginOrSignUpScreen extends StatelessWidget {
  const loginOrSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/or.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),

                child: Container(

                  alignment: Alignment(1, 0.94),
                  child: defaultButton(
                    color: Colors.transparent,
                    colorText: Colors.blue[500]!,
                    colorBorder: Colors.blue[500]!,
                    text: 'Sign Up',
                    onpre: (){
                      navigatorTo(
                        context,
                         singUpScreen(),
                      );
                    }
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Container(
                  alignment: Alignment(1, 0.7),
                  child: defaultButton(
                      color:Colors.blue[500]!,
                      text: 'Login',
                      onpre: (){
                        navigatorTo(
                          context,
                          const LoginScreen2(),
                        );
                      }
                  ),
                ),
              ),

            ],
          )),
        ],
      ),

   
    );
  }
}

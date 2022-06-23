import 'package:flutter/material.dart';
import 'package:w/screen/login2.dart';
import 'package:w/screen/signUp_screen.dart';

import '../main.dart';
import '../widget/components.dart';
import 'home_screen.dart';
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
              Container(

                alignment: FractionalOffset(0.5, 0.17),
                child: Text('Words Bank' ,style: TextStyle(color: Colors.blue[500]!,
                fontSize: 50,
                fontWeight:FontWeight.w500,
                    fontStyle: FontStyle.italic,
                ),),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Container(
                  alignment: FractionalOffset(1.3, 0.04),                  child:TextButton(
                    onPressed: () {
                      sharedPref.setString('id_user','-1');

                      navigatorTo(
                        context,
                        const HomeScreen(),
                      );
                    },
                    child:  Text(
                      'Skip',
                      style: TextStyle(color:Colors.blue[500]!,
                        fontWeight:FontWeight.w400,
                        fontSize: 30
                      ),
                    ),
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

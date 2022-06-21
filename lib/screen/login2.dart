import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w/screen/home_screen.dart';
import '../../widget/components.dart';
import '../cubit/word_bank_cubit.dart';
import '../cubit/word_bank_state.dart';
import '../main.dart';
import '../shared/google_sheets_api.dart';
import 'loginOrSignUp_screen.dart';
import 'register_screen.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  State<LoginScreen2> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen2> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocConsumer<WordBankCubit, WordBankStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WordBankCubit.get(context);
        Color color = WordBankCubit.get(context).color;
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(

            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/log.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(

                        alignment: FractionalOffset(0.02, 0.1),
                        child:  IconButton(
                          icon: Icon(Icons.arrow_back_outlined ,color: Colors.white,size: 45,),
                          onPressed: (){
                            navigatorTo(
                              context,
                              const loginOrSignUpScreen(),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),

                        child: Container(

                          alignment: Alignment(1, 0.55),
                          child:  TextFormField(
                              controller: passwordController,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.visiblePassword,
                              obscureText: !cubit.isPassword,
                              validator: (String? value) {
                              if (value!.isEmpty) {
                              return 'please enter your password';
                              }
                              if (value.length < 6) {
                              return 'password is too short';
                              }
                              return null;
                              },
                              decoration: InputDecoration(
                              label: Text(
                              'Password',
                              style: Theme.of(context)
                              .textTheme
                                  .subtitle2,
                              ),
                              //border: const OutlineInputBorder(),
                              prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                              icon: Icon(
                              cubit.suffix,
                              color: Colors.white,
                              ),
                              onPressed: () {
                              cubit.changePasswordVisibility();
                              },
                              ),
                              ),
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Container(
                          alignment: Alignment(1, 0.3),
                          child: TextFormField(
                              controller: emailController,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                              label: Text(
                              'Email Address',
                              style: Theme.of(context)
                              .textTheme
                                  .subtitle2,
                              ),
                              // border: const OutlineInputBorder(),
                              prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                              ),
                              ),
                              validator: (String? value) {
                              if (value!.isEmpty) {
                              return 'please enter your email address';
                              }
                              if (!value.contains('@') ||
                              !value.contains('.com')) {
                              return 'The email format is incorrect ';
                              }
                              return null;
                              },
                              ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Container(
                          alignment: Alignment(1, 0.9),
                          child:    BuildCondition(
                            condition: state is! LoginLoadingState,
                            builder: (context) => ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue[500]!,

                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!
                                        .validate()) {
                                      await cubit.login(
                                        context,
                                        emailController,
                                        passwordController,
                                      );
                                    }
                                  },
                                  child: const Text('login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                      )
                                    //Theme.of(context).textTheme.headline4),
                                  ),
                                ),
                              ),
                            ),
                            fallback: (context) => Center(
                                child: CircularProgressIndicator(
                                  color: color,
                                )),
                          ),

                        ),
                      ),

                    ],
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


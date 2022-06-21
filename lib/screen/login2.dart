import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w/screen/home_screen.dart';
import '../../widget/components.dart';
import '../cubit/word_bank_cubit.dart';
import '../cubit/word_bank_state.dart';
import '../main.dart';
import '../shared/google_sheets_api.dart';
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
            appBar: AppBar(
              // elevation: 0.0,
              centerTitle: true,
              title: const Text('Words bank'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline4,
                            ),
                        Text(
                          'Login now to our app',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 290,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .canvasColor, // Colors.white,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: WordBankCubit.get(context)
                                    .color
                                    .withOpacity(0.2),
                                //Theme.of(context).shadowColor,
                                spreadRadius: 5.0,
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: emailController,
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
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: passwordController,
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
//color: Theme.of(context).iconTheme.color,
                                    ),
                                    onPressed: () {
                                      cubit.changePasswordVisibility();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              BuildCondition(
                                condition: state is! LoginLoadingState,
                                builder: (context) => Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SizedBox(
                                      height: 60,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              color, //HexColor('#E7734D'),
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
                                ),
                                fallback: (context) => Center(
                                    child: CircularProgressIndicator(
                                  color: color,
                                )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  Text(
                                    'Don\'t have an account?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      navigatorTo(
                                        context,
                                        RegisterScreen(),
                                      );
                                    },
                                    child: Text(
                                      'register',
                                      style: TextStyle(color: color),
                                    ),
                                  ),
                                  const Spacer()
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () async{
                            sharedPref.setString('id_user', '-1');
                            navigatorTo(
                              context,
                              const HomeScreen(),
                            );
                          },
                          child: Text(
                            'Skip without sign up',
                            style: TextStyle(color: color),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

//////////////////////

// Container(
// width: double.infinity,
// height: 180,
// decoration: const BoxDecoration(
// color:Colors.indigoAccent,
// borderRadius: BorderRadius.only(
// bottomLeft: Radius.circular(20),
// bottomRight: Radius.circular(20),
// ),
// ),
// ),

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/word_bank_cubit.dart';
import '../cubit/word_bank_state.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WordBankCubit, WordBankStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WordBankCubit.get(context);
        Color color = WordBankCubit.get(context).color;
        return Scaffold(
          key: scaffold,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('REGISTER',
                          style: Theme.of(context).textTheme.headline4),
                      Text('Register now to our app',
                          style: Theme.of(context).textTheme.bodyText1),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.name,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your user name';
                          }
                          if (value.length < 3) {
                            return 'User name is too short';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            'User Name',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text(
                            'Email Address',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          //  border: const OutlineInputBorder(),

                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                          if (!value.contains('@') || !value.contains('.com')) {
                            return 'The email format is incorrect ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
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
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          //  border: const OutlineInputBorder(),

                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              cubit.suffix,
                              // color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              cubit.changePasswordVisibility();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      BuildCondition(
                        condition: state is! SingUpLoadingState,
                        builder: (context) => Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 60.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: color, //HexColor('#E7734D'),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (formKey.currentState!.validate()) {
                                    await cubit.signUp(
                                      context,
                                      emailController,
                                      passwordController,
                                      usernameController,
                                    );
                                  }
                                },
                                child: const Text(
                                  'register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28),
                                ),
                              ),
                            ),
                          ),
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(
                            color: color,
                          ),
                        ),
                      ),
                    ],
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

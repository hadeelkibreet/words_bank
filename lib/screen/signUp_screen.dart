import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/word_bank_cubit.dart';
import '../cubit/word_bank_state.dart';
import '../widget/components.dart';
import 'loginOrSignUp_screen.dart';

class singUpScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  singUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WordBankCubit, WordBankStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WordBankCubit.get(context);
        Color color = WordBankCubit.get(context).color;
        return Scaffold(
          key: scaffold,
          // appBar: AppBar(
          //   iconTheme: const IconThemeData(color: Colors.white),
          // ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/sign.jpg'),
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

                        //                              style: TextStyle(color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),

                          child: Container(

                            alignment: Alignment(1, 0.00),
                            child:                 TextFormField(
                              controller: usernameController,
                              style: TextStyle(color: Colors.white),
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

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),

                          child: Container(

                            alignment: Alignment(1, 0.3),
                            child:                  TextFormField(
                              controller: emailController,
                              style: TextStyle(color: Colors.white),
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

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),

                          child: Container(

                            alignment: Alignment(1, 0.6),
                            child:                  TextFormField(
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
                            alignment: Alignment(1, 0.9),
                            child:                  BuildCondition(
                              condition: state is! SingUpLoadingState,
                              builder: (context) => ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 60.0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[500]!, //HexColor('#E7734D'),
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
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 28),
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

                          ),
                        ),


                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}


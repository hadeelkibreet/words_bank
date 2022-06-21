import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:w/screen/home_screen.dart';
import '../cubit/word_bank_cubit.dart';
import '../cubit/word_bank_state.dart';
import '../widget/components.dart';
import 'login_screen.dart';


// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  String email;

  OtpScreen({Key? key, required this.email}) : super(key: key);

  late String otpCode;

  Widget _buildIntroTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'Verify your Email',
          style:Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 8 digit code numbers sent to ',
               style: Theme.of(context).textTheme.subtitle1,
              children: <TextSpan>[
                TextSpan(
                  text: email,
                   style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog =  AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
        color: WordBankCubit.get(context).color,
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      length: 8,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: WordBankCubit.get(context).color,
        inactiveColor: Colors.grey,//MyColors.blue,
        inactiveFillColor: Colors.white,
        activeFillColor: WordBankCubit.get(context).color.withOpacity(0.1),//MyColors.lightBlue,
        selectedColor: WordBankCubit.get(context).color,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (submittedCode) {
        otpCode = submittedCode;
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },
    );
  }



  Widget _buildVerifyButton(BuildContext context) {
    var cubit = WordBankCubit.get(context);
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);
           cubit.otp(otpCode,context);
        },
        child: const Text(
          'Verify',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          primary: WordBankCubit.get(context).color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailVerificationBloc() {
    return BlocListener<WordBankCubit, WordBankStates>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
        if (state is EmailSubmitted) {
          Navigator.pop(context);
          navigatorFinish(context, const HomeScreen()) ;
        }

        if (state is ErrorOccurred) {
          Navigator.pop(context);
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildIntroTexts(context),
                const SizedBox(
                  height: 88,
                ),
                _buildPinCodeFields(context),
                const SizedBox(
                  height: 60,
                ),
                _buildVerifyButton(context),
                _buildEmailVerificationBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
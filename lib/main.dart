import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w/screen/login2.dart';
import 'package:w/screen/login_screen.dart';
import 'package:w/screen/splash_screen.dart';
import 'package:w/shared/bloc_observer.dart';
import 'cubit/word_bank_cubit.dart';
import 'cubit/word_bank_state.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WordBankCubit()
        ..createDataBase()
        ..checkColor()
        ..initPlatformState(),
      child: BlocConsumer<WordBankCubit, WordBankStates>(
        listener: (context, state) {},
        builder: (context, state) {
          Color _color = WordBankCubit.get(context).color;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.grey,
              //WordBankCubit.get(context).color,//colorCustom,
              primaryColor: WordBankCubit.get(context).color,
              //colorCustom,
              canvasColor: Colors.white,
              //shadowColor: colorCustom.withOpacity(0.15),//Colors.indigo.withOpacity(0.2),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                color: _color,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              textTheme: const TextTheme(
                headline6: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                headline1: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                headline4: TextStyle(
                  color: Colors.black,
                ),
                bodyText1: TextStyle(
                  color: Colors.black,
                ),
                subtitle1: TextStyle(
                  color: Colors.black,
                ),
                subtitle2: TextStyle(
                  color: Colors.grey,
                ),
              ),
              iconTheme: IconThemeData(
                color: _color,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: WordBankCubit.get(context).color,
                foregroundColor: Colors.white,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: _color,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                //selectedIconTheme: IconThemeData(color: Colors.lightGreen,),
              ),
            ),
            // darkTheme: ThemeData(
            //   primarySwatch: colorDark,
            //   primaryColor: Colors.grey,
            //  canvasColor: HexColor('#6C757D'),
            //   shadowColor: Colors.grey.withOpacity(0.2),
            //   scaffoldBackgroundColor: HexColor('#343A40'),
            //   appBarTheme: const AppBarTheme(
            //     titleTextStyle: TextStyle(
            //       color: Colors.white,
            //       fontSize: 24.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     iconTheme: IconThemeData(
            //       color: Colors.white,
            //     ),
            //   ),
            //   textTheme: const TextTheme(
            //     headline6: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     headline1: TextStyle(
            //       color: Colors.white,
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     headline4: TextStyle(
            //       color: Colors.white,
            //     ),
            //     bodyText1: TextStyle(
            //       color: Colors.white,
            //     ),
            //     subtitle1: TextStyle(
            //       color: Colors.white,
            //     ),
            //     subtitle2: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.normal,
            //     ),
            //   ),
            //   iconTheme: const IconThemeData(
            //     color: Colors.white,
            //   ),
            //   floatingActionButtonTheme:FloatingActionButtonThemeData(
            //     backgroundColor:HexColor('#6C757D') ,
            //   ),
            // ),
            // themeMode: WordBankCubit.get(context).isDark
            //     ? ThemeMode.dark
            //     : ThemeMode.light,
          //  home: const SplashScreen(),
            home: const LoginScreen2(),
            //home: const PickerColors(),
          );
        },
      ),
    );
  }
}

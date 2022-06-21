import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sqflite/sqflite.dart';
import '../main.dart';
import '../screen/home_screen.dart';
import '../screen/otp_screen.dart';
import '../shared/api.dart';
import '../shared/constant.dart';
import '../widget/components.dart';
import 'word_bank_state.dart';

class WordBankCubit extends Cubit<WordBankStates> {
  WordBankCubit() : super(WordBankInitialState());

  static WordBankCubit get(context) => BlocProvider.of(context);


  //**************************************search FUNCTION *******************************//




  //**************************************Colors FUNCTIONS *******************************//

    late Color  color ;

  void changeColors(Color color){

    this.color =color;
    emit(ColorsState());
  }

  void  checkColor(){
    if (sharedPref.getString('color') == null)
    {
       color = Colors.indigoAccent;
    }
    else
    {
      saveColor(sharedPref.getString('color').toString());//return color = Colors.black;//sharedPref.getString('color') as Color;
    }
  }


  void saveColor(numColor) {
    switch (numColor) {
      case "ColorSwatch(primary value: Color(0xffffc107))":
     // case "MaterialColor(primary value: Color(0xffffc107))":
        {
          color =  Colors.amber;
          print('1');
        }
        break;
      case  "ColorSwatch(primary value: Color(0xffff9800))":
     // case  "MaterialColor(primary value: Color(0xffff9800))":
        {
          color =    Colors.orange;
          print('2');
        }
        break;
      case "ColorSwatch(primary value: Color(0xffff6e40))":
     // case "MaterialAccentColor(primary value: Color(0xffff6e40))":
        {
          color =  Colors.deepOrange;
          print('3');
        }
        break;
      case "ColorSwatch(primary value: Color(0xffff5722))":
      //case "MaterialColor(primary value: Color(0xffff5722))":
        {
          color = Colors.deepOrangeAccent;
          print('4');
        }
        break;
      case "ColorSwatch(primary value: Color(0xfff44336))":
     // case "MaterialColor(primary value: Color(0xfff44336))":
        {
          color =  Colors.red;
          print('5');
        }
        break;

      case "ColorSwatch(primary value: Color(0xffff4081))":
    //  case "MaterialAccentColor(primary value: Color(0xffff4081))":
        {
          color =  Colors.pinkAccent;
          print('6');
        }
        break;
      case "ColorSwatch(primary value: Color(0xffe91e63))":
      //case "MaterialColor(primary value: Color(0xffe91e63))":
        {
          color =   Colors.pink;
          print('7');
        }
        break;
      case "ColorSwatch(primary value: Color(0xff9c27b0))":
     // case "MaterialColor(primary value: Color(0xff9c27b0))":
        {
          color =  Colors.purple;
          print('8');
        }
        break;
      case "ColorSwatch(primary value: Color(0xff673ab7))":
     // case "MaterialColor(primary value: Color(0xff673ab7))":
        {
          color = Colors.deepPurple;
          print('9');
        }
        break;
      case "ColorSwatch(primary value: Color(0xff7c4dff))":
      //case "MaterialAccentColor(primary value: Color(0xff7c4dff))":
        {
          color =  Colors.deepPurpleAccent;
          print('10');
        }
        break;


      case "ColorSwatch(primary value: Color(0xff3f51b5))":
     // case "MaterialColor(primary value: Color(0xff3f51b5))":
        {
          color =  Colors.indigo;
          print('11');
        }
        break;
      case  "ColorSwatch(primary value: Color(0xff2196f3))":
     // case  "MaterialColor(primary value: Color(0xff2196f3))":
        {
          color =    Colors.blue;
          print('12');
        }
        break;
      case "ColorSwatch(primary value: Color(0xff03a9f4))":
      //case "MaterialColor(primary value: Color(0xff03a9f4))":
        {
          color =  Colors.lightBlue;
          print('13');
        }
        break;
      case "ColorSwatch(primary value: Color(0xff00bcd4))":
     // case "MaterialColor(primary value: Color(0xff00bcd4))":
        {
          color = Colors.cyan;
          print('14');
        }
        break;
      case "ColorSwatch(primary value: Color(0xff009688))":
     // case "MaterialColor(primary value: Color(0xff009688))":
        {
          color =  Colors.teal;
          print('15');
        }
        break;


      case "ColorSwatch(primary value: Color(0xff4caf50))":
      //case "MaterialColor(primary value: Color(0xff4caf50))":
        {
          color =  Colors.green;
          print('16');
        }
        break;
      case  "ColorSwatch(primary value: Color(0xff8bc34a))":
     // case  "MaterialColor(primary value: Color(0xff8bc34a))":
        {
          color =    Colors.lightGreen;
          print('17');
        }
        break;
      case "ColorSwatch(primary value: Color(0xff795548))":
     // case "MaterialColor(primary value: Color(0xff795548))":
        {
          color =  Colors.brown;
          print('18');
        }
        break;
      case "ColorSwatch(primary value: Color(0xff9e9e9e))":
     // case "MaterialColor(primary value: Color(0xff9e9e9e))":
        {
          color = Colors.grey;
          print('19');
        }
        break;
      case "ColorSwatch(primary value: Color(0xff607d8b))":
        {
          color =  Colors.blueGrey;
          print('20');
        }
        break;
      default: {
        color =  Colors.indigoAccent;
      }
      break;
    }
  }




  //**************************************SQLITE FUNCTIONS *******************************//

  Database? database;
  List<Map> newAccount = [];
  List Word2sE = [];
  List Word2sA = [];
  List Word2sId = [];
  List worddescription=[];

  bool isBottonSheetShow =false;
  int currentIndex = 2;
  int allQuestion = 1;
  bool isTrueAnswer=false;
  int numOfTrueAnswer=0;
  bool isEn = true;

  void changelang() {
    isEn = !isEn;
    print(isEn.toString());
    emit(WordBankChangeLangState());
  }
  void uppdataSearch() {

    emit(WordBankuppdataSearchState());
  }

  void createDataBase() {
    emit(WordBankInitialHomeState());
    //emit(WordBankGetDatabaseLoadingState());
    openDatabase(
      'wordBanks.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database.execute('CREATE TABLE users ('
            'id INTEGER PRIMARY KEY,username varchar(255) NOT NULL,password varchar(255) DEFAULT NULL,'
            'email varchar(255) NOT NULL UNIQUE,id_google int(11) DEFAULT NULL)'
        ).then((value) {
          print('First table created ');
        }).catchError((error) {
          print('Error When Creating First Table ${error.toString()}');
        });
        database.execute(
            'CREATE TABLE wordBanks (id INTEGER PRIMARY KEY, englishWord TEXT, arabicWord TEXT, description TEXT,'
                'id_user int(11) NOT NULL,FOREIGN KEY (id_user)REFERENCES users(id))')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database)
      {
        print('database opened ');
      },
    ).then((value) {
      database = value;
    });
    emit(WordBankGetDatabaseState());
  }


  insertWordsToDatabase({
    required String englishWord,
    required String arabicWord,
    required String description,
    required int idUser,
  }) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
        'INSERT INTO wordBanks (id_user ,englishWord, arabicWord, description) VALUES($idUser,"$englishWord", "$arabicWord", "$description")',
      ).then((value)
      {
        print('$value inserted successfully');
        getWordsDataBase(database,int.parse(sharedPref.getString('id_user')!),);
        emit(WordBankInsertDatabaseState());
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }


  insertUserToDatabase({
    required var usernameCon,
    required var emailCont,
    required var passwordCont,
  }) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
        'INSERT INTO users ( username, password, email) VALUES("${usernameCon.text}", "${passwordCont.text}", "${emailCont.text}")',
      ).then((value)
      {
        print('$value inserted into user table successfully');
        emit(UsersInsertDatabaseState());
      }).catchError((error) {
        print('Error When Inserting New User ${error.toString()}');
      });
    });
  }


  Future<void> getWordsDataBase(database , int id) async {
    emit(WordBankGetDatabaseLoadingState());
    print(newAccount.toString()+'after get');

    newAccount = await database.rawQuery('SELECT * FROM wordBanks Where id_user =$id  ');

    for (int i = 0; i <newAccount.length ; i++)
    {
      if(Word2sE!=newAccount[i]['englishWord'])
      {
        Word2sId.add(newAccount[i]['id']);

        Word2sE.add(newAccount[i]['englishWord']);

        Word2sA.add(newAccount[i]['arabicWord']);

        worddescription.add(newAccount[i]['description']);
      }

    }



    print(Word2sE.toString()+'EEEEEEEE'+Word2sA.toString()+'aaaaaaaaaaaaa');

    print(newAccount.toString());
    emit(WordBankGetDatabaseState());

    // Word2sId=[];
    // Word2sE=[];
    // Word2sA=[];
    // worddescription=[];
    // print(Word2sE.toString()+'EEEEEEEE'+Word2sA.toString()+'aaaaaaaaaaaaa');

  }





  void deleteData({
    required int id,
  }) async {
    database!
        .rawDelete('DELETE FROM wordBanks WHERE id = ?', [id]).then((value) {
      getWordsDataBase(database,int.parse(sharedPref.getString('id_user')!),);
      emit(WordBankDeleteDatabaseState());
    });
  }


  Future<void> updateData({
    required int id,
    required String englishWord,
    required String arabicWord,
    required String description,
  }) async {
    await database!.rawUpdate(
        "UPDATE 'wordBanks' SET 'englishWord' = ?, 'arabicWord' = ? , 'description'=?  WHERE id =  $id",
        [
          englishWord,
          arabicWord,
          description,
        ]).then((value) {
      print('$value inserted successfully');
      getWordsDataBase(database,int.parse(sharedPref.getString('id_user')!),);
      emit(WordBankUpdateDatabaseState());
    });
  }



  //**************************************QUIZ FUNCTION *******************************//


  void changeAnswer(bool isAnswer) {
    //emit(WordBankInitQuizState());
    isTrueAnswer=isAnswer;
    print(isTrueAnswer);

    numOfTrueAnswer=numOfTrueAnswer+1;
    emit(WordBankAnswerState());
  }
  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(WordBankChangeModeState());
    } else {
      isDark =! isDark;
      sharedPref.setBool('isDark', isDark).then((value) {
        emit(WordBankChangeModeState());
      });
    }
  }


  void changeanswer(bool isanswer) {
    isTrueAnswer=isanswer;
    print(isTrueAnswer);
    // if(isanswer==true)
    // {
    //  numOfTrueAnswer=numOfTrueAnswer+1;
    // }
    emit(WordBankAnswerState());
  }
  void changeCurrIndex(int index,context) {
    currentIndex = index;
    if(index==0)  {
      allQuestion=allQuestion-1;
    }

    if (index == 1) {
      print(allQuestion.toString()+'skip');
    }

    if (index == 2) {
      if(isTrueAnswer==true||isTrueAnswer==false)
      {
        allQuestion=allQuestion+1;

      }
      if(isTrueAnswer==true)
      {

        numOfTrueAnswer=numOfTrueAnswer+1;

        showDialog<String>(
          context: context,
          builder: (BuildContext context) =>  const Icon(Icons.check_circle_outline,color: Colors.green,size: 200.0,),
        );
      }else
      {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => const  Icon(Icons.cancel_outlined,color: Colors.red,size: 200.0,),
        );
      }
      isTrueAnswer=false;
      print(allQuestion.toString()+'next');
    }
    emit(WordBankQuizState());

    //  emit(WordBankInitQuizState());

  }

  //**************************************LOGIN FUNCTION *******************************//

  final Api _api = Api();

  login(BuildContext context, var emailCont, var passwordCont) async {
    emit(LoginLoadingState());
    bool internetConnection = await InternetConnectionChecker().hasConnection;
    if(internetConnection)
    {
      var response = await _api.postRequest(linkLogin, {
        "email": emailCont.text,
        "password": passwordCont.text,
      });
      if (response['status'] == 'success') {
        createDataBase();
        sharedPref.setString("id_user", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        showSnackBar(context, 'Login successful');
        navigatorFinish(
          context,
          const HomeScreen(),
        );
      } else {
        print('Error login field ');
        showSnackBar(context, 'The email or password is incorrect');
      }
      emit(LoginSuccessState());
    }
    else
      {
        showSnackBar(context, 'You do not have internet');
      }
  }


  otp(String otp ,BuildContext context) async {
    var response = await _api.postRequest(linkOtp, {
      "verification_code": otp,
    });

    if (response['status'] == 'success') {
      emit(Loading());
      showSnackBar(context, 'Account successfully created');
      emit(EmailSubmitted());
    }
    else{
      showSnackBar(context, 'The code incorrect');
       emit(ErrorOccurred());
    }
  }



  //**************************************SIGNUP FUNCTION *******************************//

  signUp(
      BuildContext context,
      var emailCont,
      var passwordCont,
      var usernameCon,
      ) async {
    emit(SingUpLoadingState());
    var response = await _api.postRequest(linkSignUp, {
      "username": usernameCon.text,
      "email": emailCont.text,
      "password": passwordCont.text,
    });
    bool internetConnection = await InternetConnectionChecker().hasConnection;
    print('=============================333===>' + response.toString());
    if(internetConnection)
    {
     // print(response+'8********************');
    if (response['status'] == 'send verify code successfully') {
        // print(response.toString());
        insertUserToDatabase(
        passwordCont: passwordCont.text,
        usernameCon:usernameCon.text,
        emailCont: emailCont.text,
      );
        print('================================> Account successfully created');
        //showSnackBar(context, 'Account successfully created');
        //Navigator.pop(context);
      navigatorFinish(context, OtpScreen(email: emailCont.text));
    }
   else if(response['nuCod'] == "40")
    {
      //print(response.toString());
      print('================================> Email is already exist ');
      showSnackBar(context, 'Email is already exist');
    }
    else
     {
       print(response.toString());
       print('================================> Error signup field ');
       showSnackBar(context, 'Account created failed');
    }
    emit(SingUpSuccessState());
    }
    else{
      print('================================> You do not have internet');
      showSnackBar(context, 'You do not have internet');
    }
  }

  //**************************************BACKUP FOR SERVER FUNCTION *******************************//

  getNotesFromServer() async {
    emit(WordBankGetDatabaseLoadingState());
    var response = await _api.postRequest(linkViewNotes, {
      "id": sharedPref.getString("id_user"),
    });
    if(response['data'] != null) {
      for (int i = 0; i < response['data'].length; i++) {
        await insertWordsToDatabase(
            englishWord: response['data'][i]['English_word'].toString(),
            arabicWord: response['data'][i]['Arabic_word'].toString(),
            description: response['data'][i]['Description'] ?? '',
            idUser: int.parse(sharedPref.getString("id_user")!));
      }
    }
  }

  sendNotesToServer() async {
    var response;
    for (int i = 0; i < newAccount.length; i++) {
      response = await _api.postRequest(linkInsertNotes, {
        "id_user": sharedPref.getString("id_user"),
        "English_word": newAccount[i]['englishWord'],
        "Arabic_word": newAccount[i]['arabicWord'],
        "Description": newAccount[i]['description'],
      });
    }
    return response;
  }

  deleteNotesFromServer()async{
    await _api.postRequest(linkDeleteNotes,
        {
          "id": sharedPref.getString("id_user"),
        }
    );
  }

  firstBackUp() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print(' THERE IS INTERNET ');
      if (newAccount.isEmpty) {
        await getNotesFromServer();
        print(' SQL LITE is EMPTY');
        emit(WordBankGetDatabaseState());
      } else {
        await deleteNotesFromServer();
        await sendNotesToServer();
        print(' SQL LITE IS NOT EMPTY');
      }
    } else {
      print(' No internet ');
      if (newAccount.isEmpty) {
        print(' SQL LITE is EMPTY');
      } else {
        print('SQL LITE IS NOT EMPTY');
      }
    }
    print(' THE FIRST BACK UP ');

  }

  secondBackUp() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print(' THERE IS INTERNET ');
      if (newAccount.isEmpty) {
         deleteNotesFromServer();
       // print(' SQL LITE is EMPTY');
      } else {
         deleteNotesFromServer();
        await sendNotesToServer();
        print(' SQL LITE IS NOT EMPTY');
      }
    }
    print(' THE SECOND BACK UP ');

  }


//************************************** SNACK BAR FUNCTIONS *******************************//



  void showSnackBar(BuildContext context ,String message ){
    final snackBar =  SnackBar (
      behavior: SnackBarBehavior.floating,
      content:  Text(
        message,
      ),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSnackBarWithAction(BuildContext context ,String message,String label ,void Function() onPressed){
    final snackBar =  SnackBar (
      behavior: SnackBarBehavior.floating,
      content:  Text(
        message,
      ),
      action: SnackBarAction(
        label: label,
        onPressed: onPressed
      ),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



//************************************** FUNCTIONS *******************************//

  bool isBottomSheetShow = false;
  IconData iconBottom = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShow = isShow;
    iconBottom = icon;
    emit(AppChangeBottomSheetStates());
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }



//************************************** One Signal FUNCTIONS  *******************************//


Future<void> initPlatformState() async {
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId('a7e5b53c-d103-483a-81a0-f26344d8a46b');
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
 }




}



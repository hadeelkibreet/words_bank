abstract class WordBankStates {}

class WordBankInitialState extends WordBankStates {}

class WordBankInitialHomeState extends WordBankStates {}

class WordBankInitialHome2State extends WordBankStates {}

class WordBankCreateDatabaseState extends WordBankStates {}

class WordBankGetDatabaseLoadingState extends WordBankStates {}

class WordBankGetDatabaseLoading2State extends WordBankStates {}

class WordBankGetDatabaseState extends WordBankStates {}

class WordBankInsertDatabaseState extends WordBankStates {}

class WordBankUpdateDatabaseState extends WordBankStates {}

class WordBankDeleteDatabaseState extends WordBankStates {}

class WordBankChangeModeState extends WordBankStates {}

class AppChangeBottomSheetStates extends WordBankStates {}

class WordBankChangeLangState extends WordBankStates {}


//*********************** quiz *************************//


class WordBankInitQuizState extends WordBankStates {}

class WordBankQuizState extends WordBankStates {}

class WordBankAnswerState extends WordBankStates {}

class WordBankChangeColorAnswerState extends WordBankStates {}



//*********************** user *************************//

class UsersInsertDatabaseState extends WordBankStates {}

//*************************** LOGIN STATES *************************//

//class LoginInitialState extends WordBankStates {}

class LoginLoadingState extends WordBankStates {}

class LoginSuccessState extends WordBankStates {}

class LoginErrorState extends WordBankStates {}


//*************************** OTP STATES *************************//


class Loading extends WordBankStates {}

class ErrorOccurred extends WordBankStates {}

class EmailSubmitted extends WordBankStates{}

class EmailOTPVerified extends WordBankStates{}

class ColorsState extends WordBankStates{}
class WordBankuppdataSearchState extends WordBankStates {}

//*************************** SING UP STATES *************************//

//class SingUpInitialState extends WordBankStates {}

class SingUpLoadingState extends WordBankStates {}

class SingUpSuccessState extends WordBankStates {}

//class SingUpErrorState extends WordBankStates {}

//*************************** SING UP STATES *************************//


class ChangePasswordVisibilityState extends WordBankStates {}

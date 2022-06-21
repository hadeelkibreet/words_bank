import 'package:flutter/material.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../cubit/word_bank_cubit.dart';
import '../screen/edit_screen.dart';

void navigatorTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void NavigatorFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

Widget QuizBankBuilder({
  required List<dynamic> cubitIndex,
  required List<dynamic> AnswerIndex2,
}) =>
    BuildCondition(
      condition: cubitIndex.isNotEmpty,
      builder: (context) {
        return BuildQuestion(
            cubitIndex[AnswerIndex2[0]],
            cubitIndex[AnswerIndex2[1]],
            cubitIndex[AnswerIndex2[2]],
            cubitIndex[AnswerIndex2[3]],
            context);
      },
      fallback: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.menu,
                size: 100.0,
                color: Colors.grey,
              ),
              Text(
                ' You do not have any word :(  ',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );

BuildQuestion(model1, model2, model3, model4, context) {
  List<String> ans = [
    '${model1['arabicWord']}',
    '${model2['arabicWord']}',
    '${model3['arabicWord']}',
    '${model4['arabicWord']}'
  ];
  print(ans.toString() + ' before ans run');
  ans.shuffle();
  print(ans.toString() + ' after ans run');

  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            "Question ${WordBankCubit.get(context).allQuestion} : ",
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 28.0,
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 120.0,
          child: Text(
            "What the meaning of : ${model1['englishWord']} ? ",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22.0,
            ),
          ),
        ),
        for (int i = 0; i < ans.length; i++)
          ClipRRect(
            borderRadius: BorderRadius.circular(90.0),
            child: Container(
              color: WordBankCubit.get(context).color.withOpacity(0.6),
              width: double.infinity,
              height: 65.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: RawMaterialButton(
                onPressed: () {
                  if (ans[i] == model1['arabicWord']) {
                    WordBankCubit.get(context).changeanswer(true);
                    WordBankCubit.get(context).changeCurrIndex(2, context);
                  } else {
                    WordBankCubit.get(context).changeanswer(false);
                    WordBankCubit.get(context).changeCurrIndex(2, context);
                  }
                },
                child: Text(
                  ans[i],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget buildWordBankItem(model, context) => Dismissible(
    key: UniqueKey(),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          navigatorTo(
            context,
            EditScreen(
              id: model['id'].toString(),
              english: model['englishWord'].toString(),
              arabic: model['arabicWord'].toString(),
              description: model['description'].toString(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor, // Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: WordBankCubit.get(context)
                    .color
                    .withOpacity(0.2), //Theme.of(context).shadowColor,
                spreadRadius: 5.0,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${model['englishWord']}'.length > 10
                        ? '${model['englishWord']}'.substring(0, 10) + '...'
                        : '${model['englishWord']}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Icon(
                    Icons.compare_arrows,
                    size: 35.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${model['arabicWord']}'.length > 10
                          ? '${model['arabicWord']}'.substring(0, 10) + '...'
                          : '${model['arabicWord']}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0, right: 10.0, left: 10.0),
                child: Text(
                  '${model['description']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    onDismissed: (direction) {
      var cubit = WordBankCubit.get(context);
      cubit.deleteData(id: model['id']);
      cubit.showSnackBarWithAction(context, 'Deleted successfully', 'Undo', () {
        cubit.insertWordsToDatabase(
            englishWord: model['englishWord'].toString(),
            arabicWord: model['arabicWord'].toString(),
            description: model['description'].toString(),
            idUser: model['id_user']);
      });
    });

Widget wordBankBuilder({
  required List<dynamic> cubitIndex,
}) =>
    BuildCondition(
      condition: cubitIndex.isNotEmpty,
      builder: (context) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildWordBankItem(cubitIndex[index], context),
          separatorBuilder: (context, index) => myDivider2(),
          itemCount: cubitIndex.length,
        );
      },
      fallback: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                size: 100.0,
                color: WordBankCubit.get(context)
                    .color
                    .withOpacity(0.5), //Colors.grey,
              ),
              Text(
                ' Start with the first word ',
                style: TextStyle(
                  fontSize: 20.0,
                  color: WordBankCubit.get(context)
                      .color
                      .withOpacity(0.5), //Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );

Widget myDivider2() => Container(
      width: double.infinity,
      height: 0.0,
      color: Colors.grey[300],
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

void navigatorFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

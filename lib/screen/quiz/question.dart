import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w/screen/quiz/result_quiz.dart';
import '../../cubit/word_bank_cubit.dart';
import '../../cubit/word_bank_state.dart';
import '../../widget/components.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WordBankCubit, WordBankStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WordBankCubit.get(context);
        List list1 = WordBankCubit.get(context).newAccount;
        Set<int> setOfInts = {};
        for (int i = 1; setOfInts.length < 4; i++) {
          setOfInts.add(Random().nextInt(cubit.newAccount.length));
        }
        print(setOfInts.toString() + 'set');
        final List<int> list2 = setOfInts.toList();
        print(list2.toString() + 'list');
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Quiz',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () {
                    cubit.changeCurrIndex(0, context);
                    navigatorFinish(context, const ResultQuiz());
                  },
                  child: const Text(
                    'finish',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )),
            ],
            leading: TextButton(
              onPressed: () {
                cubit.changeCurrIndex(1, context);
              },
              child: const Text(
                'skip',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                QuizBankBuilder(cubitIndex: list1, AnswerIndex2: list2),
              ],
            ),
          ),
        );
      },
    );
  }
}

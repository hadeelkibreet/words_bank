import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w/screen/quiz/question.dart';
import '../../cubit/word_bank_cubit.dart';
import '../../cubit/word_bank_state.dart';
import '../../widget/components.dart';
import '../home_screen.dart';

class ResultQuiz extends StatelessWidget {
  const ResultQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var  result = (WordBankCubit.get(context).numOfTrueAnswer * 100) / WordBankCubit.get(context).allQuestion;
    var _result = (result.isNaN || result.isInfinite) ? 0 : result;

    // void result(){
    //   if (_result.isNaN || _result.isInfinite){
    //     _result = 0;
    //   }
    // }

    return BlocConsumer<WordBankCubit, WordBankStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = WordBankCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Result Quiz '),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  cubit.isTrueAnswer = false;
                  cubit.numOfTrueAnswer = 0;
                  cubit.allQuestion = 1;
                  navigatorFinish(context, const HomeScreen());
                },
                icon: const Icon(Icons.home_outlined),
                iconSize: 30,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    cubit.isTrueAnswer = false;
                    cubit.numOfTrueAnswer = 0;
                    cubit.allQuestion = 1;
                    navigatorFinish(context, QuestionScreen());
                  },
                  icon: const Icon(Icons.restart_alt),
                  iconSize: 30,
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    cubit.numOfTrueAnswer >= cubit.allQuestion
                        ? Icons.volunteer_activism
                        : Icons.warning_amber_outlined,
                    size: 200,
                    color: cubit.numOfTrueAnswer >= cubit.allQuestion
                        ? Colors.blue
                        : Colors.red,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    _result.toInt().toString() + '%',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Correct answers:' + cubit.numOfTrueAnswer.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Incorrect answers:' +
                        (cubit.allQuestion - cubit.numOfTrueAnswer).toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('All questions:' + cubit.allQuestion.toString(),
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
          );

        });
  }
}

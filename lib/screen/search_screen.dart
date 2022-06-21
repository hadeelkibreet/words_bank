import 'package:flutter/material.dart';
import '../cubit/word_bank_cubit.dart';
import '../widget/components.dart';
import 'edit_screen.dart';
import 'home_screen.dart';

class WordSearch extends SearchDelegate {
  List englishWords;
  List arabicWords;
  WordSearch(this.englishWords, this.arabicWords);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () {
            query = '';

            WordBankCubit.get(context).changelang();

            query = '';


          },
          child: Text(
            WordBankCubit.get(context).isEn ? 'En' : 'Ar',
            style: const TextStyle(fontSize: 25, color: Colors.grey),
          )),
      // IconButton(
      //   onPressed: () {
      //     query = '';
      //
      //    close(context, query);
      //   },
      //   icon: const Icon(
      //     Icons.clear,
      //
      //   ),
      // ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        query = '';
        close(context, query);

        navigatorTo(context, const HomeScreen());
        //close(context, query);

      },
      icon: const Icon(
        Icons.arrow_back,

      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionsA = arabicWords.where((word) {
      return word.toLowerCase().contains(query.toLowerCase());
    });
    final suggestionsE = englishWords.where((word) {
      return word.toLowerCase().contains(query.toLowerCase());
    });
    return
      Container(
        color:  WordBankCubit.get(context).color,
        child: ListView.builder(
          itemCount: WordBankCubit.get(context).isEn == true
              ? (suggestionsE.length)
              : (suggestionsA.length),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {

                          String id = '';
                          String en = '';
                          String ar = '';
                          String de = '';
                          if (WordBankCubit.get(context).isEn == true) {
                            for (int i = 0;
                            i <=
                                WordBankCubit.get(context)
                                    .Word2sE
                                    .toString()
                                    .length;
                            i++) {
                              if (WordBankCubit.get(context)
                                  .Word2sE[i]
                                  .toString() ==
                                  suggestionsE.elementAt(index).toString()) {
                                en = WordBankCubit.get(context)
                                    .Word2sE[i]
                                    .toString();
                                ar = WordBankCubit.get(context)
                                    .Word2sA[i]
                                    .toString();
                                id = WordBankCubit.get(context)
                                    .Word2sId[i]
                                    .toString();
                                de = WordBankCubit.get(context)
                                    .worddescription[i]
                                    .toString();

                                break;
                              }
                            }
                          } else {
                            for (int i = 0;
                            i <=
                                WordBankCubit.get(context)
                                    .Word2sA
                                    .toString()
                                    .length;
                            i++) {
                              if (WordBankCubit.get(context)
                                  .Word2sA[i]
                                  .toString() ==
                                  suggestionsA.elementAt(index).toString()) {
                                en = WordBankCubit.get(context)
                                    .Word2sE[i]
                                    .toString();
                                ar = WordBankCubit.get(context)
                                    .Word2sA[i]
                                    .toString();
                                id = WordBankCubit.get(context)
                                    .Word2sId[i]
                                    .toString();
                                de = WordBankCubit.get(context)
                                    .worddescription[i]
                                    .toString();

                                break;
                              }
                            }
                          }

                          navigatorTo(
                              context,
                              // HomeScreen()
                              EditScreen(
                                id: id,
                                english: en,
                                arabic: ar,
                                description: de,
                              ));


                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  '${WordBankCubit.get(context).isEn == true ? suggestionsE.elementAt(index) : suggestionsA.elementAt(index)}'.length > 10
                                      ? '${WordBankCubit.get(context).isEn == true ? suggestionsE.elementAt(index) : suggestionsA.elementAt(index)}'.substring(0, 10) +
                                      '...'
                                      : '${WordBankCubit.get(context).isEn == true ? suggestionsE.elementAt(index) : suggestionsA.elementAt(index)}',
                                  textAlign: TextAlign.start,

                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30),
                                ),
                                Icon(Icons.subdirectory_arrow_left_sharp,
                                    color:Colors.white
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            myDivider(),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                if (WordBankCubit.get(context).isEn == true) {

                  query = suggestionsE.elementAt(index);

                  close(context, query);

                } else {
                  query = suggestionsA.elementAt(index);
                  close(context, query);

                }

              },
            );
          },
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.white,
    );

    //wordBankBuilder(cubitIndex: WordBankCubit.get(context).newAccount);
  }

//@override
// ThemeData appBarTheme(BuildContext context) {
//   return ThemeData(
//     appBarTheme:  AppBarTheme(
//       color: WordBankCubit.get(context).color,
//     ),
//   );
// }
}

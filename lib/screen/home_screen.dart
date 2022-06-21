import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w/screen/otp_screen.dart';
import 'package:w/screen/search_screen.dart';
import '../main.dart';
import '../widget/components.dart';
import '../cubit/word_bank_cubit.dart';
import '../cubit/word_bank_state.dart';
import '../widget/navdrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var formKey = GlobalKey<FormState>();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var englishController = TextEditingController();

  var arabicController = TextEditingController();

  var descriptionController = TextEditingController();

  loading() {
    return Center(
      child: CircularProgressIndicator(
        color: WordBankCubit.get(context).color,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WordBankCubit.get(context).getWordsDataBase(
      WordBankCubit.get(context).database,
      int.parse(sharedPref.getString('id_user')!),
    );
    WordBankCubit.get(context).firstBackUp();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WordBankCubit, WordBankStates>(
      listener: (context, state) {
        if (state is WordBankInsertDatabaseState) {
          WordBankCubit.get(context).secondBackUp();
        }
        if (state is WordBankDeleteDatabaseState) {
          WordBankCubit.get(context).secondBackUp();
        }
        if (state is WordBankGetDatabaseLoadingState) {
          loading();
        }
      },
      builder: (context, state) {
        List list1 = WordBankCubit.get(context).newAccount;
        var cubit = WordBankCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          drawer: const NavDar(),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Words Bank'),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: WordSearch(cubit.Word2sE, cubit.Word2sA));
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: (state is WordBankGetDatabaseLoadingState)
              ? loading()
              : wordBankBuilder(cubitIndex: list1),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheetShow) {
                if (formKey.currentState!.validate()) {
                  cubit.insertWordsToDatabase(
                    englishWord: englishController.text,
                    arabicWord: arabicController.text,
                    description: descriptionController.text,
                    idUser: int.parse(sharedPref.getString('id_user')!),
                  );
                  Navigator.pop(context);
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: englishController,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please write the english word';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  label: Text('english'),
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.edit,
                                    // color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: arabicController,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please write the arabic word';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  label: Text('arabic'),
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.edit,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: descriptionController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  labelText: 'description',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.article,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 50.0,
                    )
                    .closed
                    .then(
                  (value) {
                    cubit.isBottomSheetShow = false;
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                    englishController.text = '';
                    arabicController.text = '';
                    descriptionController.text = '';
                  },
                );
                cubit.changeBottomSheetState(
                  isShow: true,
                  icon: Icons.add,
                );
              }
            },
            child: Icon(
              cubit.iconBottom,
            ),
          ),
        );
      },
    );
  }
}

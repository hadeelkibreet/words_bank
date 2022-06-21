import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/word_bank_cubit.dart';
import '../cubit/word_bank_state.dart';

class EditScreen extends StatelessWidget {
  final String id;
  final String english;
  final String arabic;
  final String description;
  //final int searched = int.tryParse(query);

  EditScreen({
    Key? key,
    required this.id,
    required this.english,
    required this.arabic,
    required this.description,
  }) : super(key: key);

  var englishController = TextEditingController();
  var arabicController = TextEditingController();
  var descriptionController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WordBankCubit, WordBankStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                //color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextFormField(
                      controller: englishController..text = english.toString(),

                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please write the english word';
                        }
                        return null;
                      },

                      decoration: const InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        contentPadding: EdgeInsets.only( top: 10,bottom: 10),
                        border: OutlineInputBorder(),
                       // label: Text('english'),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('English : ' ,),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: arabicController..text = arabic.toString(),
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please write the arabic word';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        contentPadding: EdgeInsets.only( top: 10,bottom: 10),
                        border: OutlineInputBorder(),
                        prefixIcon: Padding(    padding: EdgeInsets.all(15.0),
                        child:
                          Text(' Arabic :'),),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Stack(
                      children:[

                      TextFormField(
                        controller: descriptionController
                          ..text = description.toString(),
                        keyboardType: TextInputType.text,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,

                          //labelText: 'description',
                          contentPadding: EdgeInsets.only( top: 50,bottom: 50,left: 50),
                          border: OutlineInputBorder( ),

                        ),
                      ),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(' Description :', style: TextStyle(fontSize: 20,color: Colors.black),),
                        ),
                      ]
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: WordBankCubit.get(context).color,
                          ),
                          onPressed: () {
                            if(formKey.currentState!.validate()) {
                              WordBankCubit.get(context).updateData(
                                englishWord: englishController.text,
                                arabicWord: arabicController.text,
                                description: descriptionController.text,
                                id: int.parse(id),
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:share/share.dart';
import 'package:w/widget/utils.dart';
import '../main.dart';
import '../screen/login_screen.dart';
import '../screen/quiz/question.dart';
import 'components.dart';
import '../cubit/word_bank_cubit.dart';

class NavDar extends StatefulWidget {
  const NavDar({Key? key}) : super(key: key);

  @override
  State<NavDar> createState() => _NavDarState();
}

class _NavDarState extends State<NavDar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: WordBankCubit.get(context)
                  .color, //cubit ? HexColor('333739') : HexColor('#E7734D'),
            ),
            accountName: Text(
              sharedPref.getString("username") ?? "USER",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              sharedPref.getString("email") ?? " ",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                    color: Colors.white,
                  ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white70,
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.quiz,
              //color: cubit ? Colors.white : Colors.grey,
            ),
            title: Text(
              'Quiz',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              if (WordBankCubit.get(context).newAccount.length < 4) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            SizedBox(
                              height: 240,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 70, 10, 10),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Warning !!!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'You must have at least 4 words',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: WordBankCubit.get(context)
                                            .color, //HexColor('#E7734D'),
                                      ),
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: -60,
                              child: CircleAvatar(
                                backgroundColor: WordBankCubit.get(context)
                                    .color, //Colors.yellow,
                                radius: 60,
                                child: const Icon(
                                  Icons.assistant_photo,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                navigatorFinish(context, const QuestionScreen());
              }
            },
          ),
          myDivider(),
          ListTile(
            leading: const Icon(
              Icons.star,
            ),
            title: Text(
              'Rate the app',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              Utils.openLink(url: 'https://play.google.com/store/apps/details?id=com.ali_natafji.words_bank');
            },
          ),
          myDivider(),
          ListTile(
            leading: const Icon(
              Icons.share,
              //color: cubit ? Colors.white : Colors.grey,
            ),
            title: Text(
              'Share the app',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              Share.share('https://play.google.com/store/apps/details?id=com.ali_natafji.words_bank');
            },
          ),
          myDivider(),
          ListTile(
              leading: const Icon(
                Icons.email,
              ),
              title: Text(
                'Connect with us',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () {
                Utils.openEmail(
                  toEmail: 'mmohammadali111@gmail.com',
                  subject: 'Words bank',
                  body: ' ',
                );
              }),
          myDivider(),
          ListTile(
            leading: const Icon(
              Icons.brightness_6_outlined,
              //color: cubit ? Colors.white : Colors.grey,
            ),
            title: Text(
              'Choose your app color',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              // WordBankCubit.get(context).changeAppMode();
              pickerColor(context);
            },
          ),
          myDivider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              //color: cubit ? Colors.white : Colors.grey,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              sharedPref.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false);
            },
          ),
          myDivider(),
        ],
      ),
    );
  }

  Widget buildColorPicker() => SizedBox(
        child: BlockPicker(
            pickerColor: WordBankCubit.get(context).color,
            availableColors: const [
              Colors.amber,
              Colors.orange,
              Colors.deepOrangeAccent,
              Colors.deepOrange,
              Colors.red,

              Colors.pinkAccent,
              Colors.pink,
              Colors.purple,
              Colors.deepPurple,
              Colors.deepPurpleAccent,

              Colors.indigo,
              Colors.blue,
              Colors.lightBlue,
              Colors.cyan,
              Colors.teal,

              Colors.green,
              Colors.lightGreen,
              Colors.brown,
              Colors.grey,
              Colors.blueGrey,
            ],
            onColorChanged: (_color) {
              WordBankCubit.get(context).changeColors(_color);
              sharedPref.setString('color', _color.toString());
              // print('************************');
              // print(sharedPref.getString('color'));
              // print('************************');
             WordBankCubit.get(context).saveColor(sharedPref.getString('color').toString());
            }),
      );


  void pickerColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Choose your app color'),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              buildColorPicker(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Select',
                  style: TextStyle(
                    color: WordBankCubit.get(context).color,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//import 'dart:math';

import 'package:flutter/material.dart';
import 'language_const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
      },
      locale: _locale,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      var translation = AppLocalizations.of(context)!;                  //
      var activeLocale = Localizations.localeOf(context).languageCode;  // for defining active Locale

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(translation.title, style: const TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 26), 
      ),
      actions:<Widget> [
          Padding(
            padding: const EdgeInsets.all(2.0),
            //настройки языка
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language? language) async {
                if (language != null) {
                  Locale _locale = await setLocale(language.languageCode);
                  MyApp.setLocale(context, _locale);
                }
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Container(
                        color:activeLocale == e.languageCode? Colors.pink[100]: null ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.flag,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Text(e.name)
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(width: 20,),
        ],),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            heroCard(context,
            translation.winnie,
            translation.date(DateTime.parse("2022-01-17")),
            translation.honey(5),
            translation.manufacturer("\"Bearhoney\""),
            translation.itemTotal(50),//'3 Jars - USD 15'
            'https://www.disneyclips.com/images/images/winnie-the-pooh26.png',
          ),

            heroCard(context,
            translation.piglet,
            translation.date(DateTime.parse("2022-03-12")),
            translation.honey(1),
            translation.manufacturer("\"Lindenhoney\""),
            translation.itemTotal(10),//'1 Jar - USD 10'
            'https://i.pinimg.com/564x/b1/d5/17/b1d517e5df335241d647870f2795d692.jpg',
          ),

            heroCard(context,
            translation.tigger,
            translation.date(DateTime.parse("2022-05-22")),
            translation.honey(2),
            translation.manufacturer("\"Acaciahoney\""),
            translation.itemTotal(20),//'3 Jars - USD 15'
            'https://www.disneyclips.com/images/images/tigger-heart.png',
          ),
          ],
        ),
      
    );
  }

}



// Widget Card

Widget heroCard(BuildContext context,
        String name, String date, String honey, String manufacturer, String total, String img ){

  return  Card(
    elevation: 5,
    shadowColor: const Color(0xFFFF7F50),
    child: Padding( 
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Image.network(img),
          ),
          const SizedBox( width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, 
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ),
              Text(date),
              Text("$honey $manufacturer"),
              Text(total),
            ],
          ),
        ],
      ),
      ),
  );
}
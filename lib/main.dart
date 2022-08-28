import 'dart:io';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Translation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String translated = 'Translation';
  final List<String> languages =
  ["Afrikaans", "Albanian", "Amharic", "Arabic", "Armenian", "Azerbaijani", "Basque"	, "Belarusian", "Bengali", "Bosnian", "Bulgarian",
    "Catalan", "Cebuano", "Chinese (Simplified)", "Chinese (Traditional)", "Corsican", "Croatian", "Czech", "Danish", "Dutch", "English", "Esperanto", "Estonian", "Finnish",
    "French", "Frisian", "Galician", "Georgian",
    "German", "Greek", "Gujarati", "Haitian",
    "Hausa", "Hawaiian", "Hebrew", "Hindi",
    "Hmong", "Hungarian", "Icelandic", "Igbo",
    "Indonesian", "Irish", "Italian", "Japanese",
    "Javanese", "Kannada", "Kazakh", "Khmer",
    "Kinyarwanda", "Korean", "Kurdish", "Kyrgyz",
    "Lao", "Latin", "Latvian", "Lithuanian",
    "Luxembourgish", "Macedonian", "Malagasy", "Malay", "Malayalam", "Maltese",
    "Maori", "Marathi", "Mongolian", "Myanmar (Burmese)",
    "Nepali", "Norwegian", "Nyanja (Chichewa)", "Odia (Oriya)",
    "Pashto", "Persian", "Polish", "Portuguese (Portugal, Brazil)",
    "Punjabi", "Romanian", "Russian", "Samoan",
    "Scots Gaelic", "Serbian", "Sesotho", "Shona", "Sindhi", "Sinhala (Sinhalese)",
    "Slovak", "Slovenian", "Somali", "Spanish", "Sundanese", "Swahili", "Swedish", "Tagalog (Filipino)",
    "Tajik", "Tamil", "Tatar", "Telugu", "Thai", "Turkish", "Turkmen", "Ukrainian",
    "Urdu", "Uyghur", "Uzbek", "Vietnamese", "Welsh", "Xhosa",
    "Yiddish", "Yoruba", "Zulu"];

  final List<String> langCodes = [
    "af",
    "sq",
    "am",
    "ar",
    "hy",
    "az",
    "eu",
    "be",
    "bn",
    "bs",
    "bg",
    "ca",
    "ceb",
    "zh-CN",
    "zh-TW",
    "co",
    "hr",
    "cs",
    "da",
    "nl",
    "en",
    "eo",
    "et",
    "fi",
    "fr",
    "fy",
    "gl",
    "ka",
    "de",
    "el",
    "gu",
    "ht",
    "ha",
    "haw",
    "he",
    "hi",
    "hmn",
    "hu",
    "is",
    "ig",
    "id",
    "ga",
    "it",
    "ja",
    "jv",
    "kn",
    "kk",
    "km",
    "rw",
    "ko",
    "ku",
    "ky",
    "lo",
    "la",
    "lv",
    "lt",
    "lb",
    "mk",
    "mg",
    "ms",
    "ml",
    "mt",
    "mi",
    "mr",
    "mn",
    "my",
    "ne",
    "no",
    "ny",
    "or",
    "ps",
    "fa",
    "pl",
    "pt",
    "pa",
    "ro",
    "ru",
    "sm",
    "gd",
    "sr",
    "st",
    "sn",
    "sd",
    "si",
    "sk",
    "sl",
    "so",
    "es",
    "su",
    "sw",
    "sv",
    "tl",
    "tg",
    "ta",
    "tt",
    "te",
    "th",
    "tr",
    "tk",
    "uk",
    "ur",
    "ug",
    "uz",
    "vi",
    "cy",
    "xh",
    "yi",
    "yo",
    "zu",];

  String tLC = 'en'; // Translated Language Code

  Future openDialog() => showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Translate To: '),
        children: <Widget>[
          Container(
            width: 250,
            height: 200,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(5),
                itemCount: languages.length,
                itemBuilder: (BuildContext c, int index) {
                  return SimpleDialogOption(
                    onPressed: () {
                      setState(() {
                        tLC = langCodes[index];
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      languages[index],
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () async{
              setState(() {
                openDialog();
              });
            },
          ),
          backgroundColor: const Color(0xFF2C2A2C),
          actions: [
            IconButton(
                onPressed: () {
                  exit(0);
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.redAccent,
                ))
          ],
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Card(
            color: const Color(0xFF1E1C1F),
            margin: const EdgeInsets.all(12),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text("Auto Detect ",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    )),
                const SizedBox(height: 8),
                TextField(
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                  ),
                  decoration: const InputDecoration(
                      hintText: 'Enter Text',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                  onChanged: (text) async {
                    final translation = await text.translate(
                      from: 'auto',
                      to: tLC,
                    );
                    setState(() {
                      translated = translation.text;
                    });
                  },
                ),
                const Divider(
                  height: 32,
                ),
                Text(
                  translated,
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
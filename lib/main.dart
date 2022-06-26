import 'dart:convert';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screens/search_screen.dart';
import 'screens/favquote_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String url =
      "https://api.quotable.io/search/quotes?query=love&limit=10";
  List data = [];
  List favoriteDataList = [];
  //  bool _hasBeenPressed =true;

  Future<void> share(List data, int index) async {
    await FlutterShare.share(
      title: 'Quote',
      text: "${"\"" + data[index]['content']}\"" +
          "${"-  " + data[index]['author']}",
    );
  }

  @override
  void initState() {
    super.initState();

    getJsonQuotedata();
  }

  Future<String> getJsonQuotedata() async {
    var res =
        await http.get(Uri.parse(url), headers: {'Accept': "application/json"});
    setState(() {
      var convertdatatojson = json.decode(res.body);
      data = convertdatatojson['results'];
    });
    return "Suceess";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quote App-REST API')),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, int index) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                     shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                    child: Container(
                      color: Colors.black87,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Text(data[index]['author'],
                            style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        // ignore: prefer_interpolation_to_compose_strings
                        Text("${"\" " + data[index]['content']} \"",
                            style: const TextStyle(
                                color: Colors.blueGrey, fontSize: 15)),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {
                                  share(data, index);
                                },
                                color: Colors.green,
                              ),
                              IconButton(
                                icon: Icon(Icons.favorite_border_outlined),
                                onPressed: () {
                                  setState(() {
                                    favoriteDataList.add(data[index]);
                                  });
                                },
                                color: Colors.yellow,
                              ),
                              IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => SearchQuote()));
                                },
                                color: Colors.orange,
                              ),
                            ]),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'http://apkpuff.com/wp-content/uploads/2021/04/Motivation-Daily-quotes-Mod-Apk.png'))),
              child: Text(
                '',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Fav Quote'),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FavQuotePage(favoriteDataList))),
              },
            ),
            ListTile(
              leading: const Icon(Icons.search_off_outlined),
              title: const Text('Search Quote'),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>SearchQuote())),
              },
            ),
          ],
        ),
      ),
    );
  }
}

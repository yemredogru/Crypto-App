import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List crypto;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchData();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: crypto.length,
                itemBuilder: (BuildContext context, int index) {
                  double price = double.parse(crypto[index]['price']);
                  return Card(
                    child: ListTile(
                      title: Text(
                        '${crypto[index]['name']}',
                        style: const TextStyle(fontSize: 7),
                      ),
                      leading: SizedBox(
                        height: 50.0,
                        width: 50.0, // fixed width and height
                        child: Image.network('${crypto[index]['logo_url']}'),
                      ),
                      subtitle: Text(
                        '\$${price.toStringAsFixed(3)}',
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    var url = Uri.parse(
        'https://api.nomics.com/v1/currencies/ticker?key=your_key');
    http.get(url).then((result) {
      var data = jsonDecode(result.body);
      crypto = data;
      setState(() {});
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

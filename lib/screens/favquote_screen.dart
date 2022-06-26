import 'package:flutter/material.dart';

class FavQuotePage extends StatefulWidget {
  List favoriteDataList;
  FavQuotePage(this.favoriteDataList);

  @override
  State<FavQuotePage> createState() => _FavQuotePageState();
}

class _FavQuotePageState extends State<FavQuotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.favoriteDataList.isEmpty
          ? const Center(
              child: Text(
                'There are no favorites yet!',
                style: TextStyle(color: Colors.black),
              ),
            )
          : ListView.builder(
              itemCount: widget.favoriteDataList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    color: Colors.black87,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      Text(widget.favoriteDataList[index]['author'],
                          style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      // ignore: prefer_interpolation_to_compose_strings
                      Text(widget.favoriteDataList[index]['content'],
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 15)),
                    
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.favoriteDataList
                                .remove(widget.favoriteDataList[index]);
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple,
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
    );
  }
}

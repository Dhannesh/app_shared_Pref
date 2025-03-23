import 'package:app_shared_pref/utils/preferences_util.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PreferencesUtil preferencesUtil = PreferencesUtil();
  final List<String> _searchTermsList = [];

  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = "No search yet";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preferencesUtil.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Insta Store'),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                if (_searchController.text.isNotEmpty) {
                                  preferencesUtil
                                      .setSearchTerm(_searchController.text);
                                  _searchController.clear();
                                }
                              }),
                        ))
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _searchTerm = preferencesUtil.getSearchTerm() ?? "";
                        });
                        _searchController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black),
                      child: Text('Recent Searches')),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.amber[50],
                      child: ListTile(
                        title: Text(_searchTerm),
                        trailing: const Icon(Icons.delete),
                        onTap: () {
                          preferencesUtil.removeSearchTerm();
                          setState(() {
                            _searchTerm = "";
                          });
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

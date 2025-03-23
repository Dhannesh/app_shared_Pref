import 'package:app_shared_pref/utils/preferences_util.dart';
import 'package:flutter/material.dart';

class AutoCompletePage extends StatefulWidget {
  const AutoCompletePage({super.key});

  @override
  State<AutoCompletePage> createState() => _AutoCompletePageState();
}

class _AutoCompletePageState extends State<AutoCompletePage> {
  PreferencesUtil preferencesUtil = PreferencesUtil();
  final List<String> _searchTermsList = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    preferencesUtil.init().then((value) {
      setState(() {
        List<String>? terms = preferencesUtil.getSearchTerms();

        if (terms != null) {
          _searchTermsList.addAll(terms);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Complete'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    RawAutocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return _searchTermsList.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          onSubmitted: (String value) {
                            setState(() {
                              if (!_searchTermsList.contains(value)) {
                                _searchTermsList.add(value);
                                preferencesUtil
                                    .setSearchTerms(_searchTermsList);
                              }
                            });
                          },
                        );
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Card(
                            elevation: 4.0,
                            child: SizedBox(
                              height: 200,
                              width: 350,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(4.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                      options.elementAt(index);
                                  return InkResponse(
                                    onTap: () {
                                      onSelected(option);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Search for $option')));
                                    },
                                    child: ListTile(
                                      title: Text(option),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

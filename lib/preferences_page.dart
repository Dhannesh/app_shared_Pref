import 'package:app_shared_pref/utils/preferences_util.dart';
import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  PreferencesUtil preferencesUtil = PreferencesUtil();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

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
        title: Text('Shared Preferences'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Column(
                      children: [
                        TextField(
                          controller: _keyController,
                          decoration: InputDecoration(
                            labelText: 'Key',
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: _valueController,
                          decoration: InputDecoration(
                            labelText: 'Value',
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: _typeController,
                          decoration: InputDecoration(
                            labelText: 'Type',
                          ),
                        ),
                      ],
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_keyController.text.isNotEmpty &&
                          _valueController.text.isNotEmpty &&
                          _typeController.text.isNotEmpty) {
                        String key = _keyController.text;
                        String valueString = _valueController.text;
                        String valueType = _typeController.text;
                        debugPrint(
                            'Setting value: $valueString for key: $key of type: $valueType');
                        switch (valueType) {
                          case 'int':
                            int value = int.parse(valueString);
                            preferencesUtil.setInt(key, value);
                            break;
                          case 'double':
                            double value = double.parse(valueString);
                            preferencesUtil.setDouble(key, value);
                            break;
                          case 'bool':
                            bool value = valueString == 'true' ? true : false;
                            preferencesUtil.setBool(key, value);
                            break;
                          case 'string':
                            preferencesUtil.setString(key, valueString);
                            break;
                          case 'string_list':
                            List<String> value = valueString.split(',');
                            preferencesUtil.setStringList(key, value);
                            break;
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black),
                    child: Text("Set"),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_keyController.text.isNotEmpty &&
                            _typeController.text.isNotEmpty) {
                          String key = _keyController.text;
                          String valueType = _typeController.text;
                          debugPrint(
                              'All preferences: ${preferencesUtil.getKeys()}');
                          switch (valueType) {
                            case 'int':
                              int? value = preferencesUtil.getInt(key);
                              _valueController.text = "$value";
                              break;
                            case 'double':
                              double? value = preferencesUtil.getDouble(key);
                              _valueController.text = "$value";
                              break;
                            case 'bool':
                              bool? value = preferencesUtil.getBool(key);
                              _valueController.text = "$value";
                              break;
                            case 'string':
                              String? value = preferencesUtil.getString(key);
                              _valueController.text = "$value";
                              break;
                            case 'string_list':
                              List<String>? value =
                                  preferencesUtil.getStringList(key);
                              _valueController.text = "${value?.join(',')}";
                              break;
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black),
                      child: Text("Get")),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

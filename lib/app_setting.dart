import 'package:app_shared_pref/utils/preferences_util.dart';
import 'package:flutter/material.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({super.key});

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  PreferencesUtil preferencesUtil = PreferencesUtil();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preferencesUtil.init().then((value) {
      setState(() {
        _settingColor = preferencesUtil.getColor() ?? 0xffffff11;
        _settingImage = preferencesUtil.getImage() ?? 'car';
      });
    });

  }

  String _settingImage = 'car';
  final List<String> _images = ['car', 'ducky', 'dino', 'engine', 'robot'];
  int _settingColor = 0xffffff11;

  final List<int> _colors = [0xffff5a64, 0xff11c1ff, 0xff79ff48];
  setColor(int color) {
    setState(() {
      _settingColor = color;
      preferencesUtil.setColor(color);
    });
  }

  setImage(String image) {
    setState(() {
      _settingImage = image;
      preferencesUtil.setImage(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(_settingColor),
      appBar: AppBar(
        title: Text('App Setting'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
                  await _showMyDialog();
            },
            child: Container(
              height: 300,
              width: 300,
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(40),
              decoration:
                  BoxDecoration(color: Colors.white70, shape: BoxShape.circle),
              child: Image.asset('images/$_settingImage.png'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkResponse(
                  onTap: () => setColor(_colors[0]),
                  child: ColorButton(_colors[0])),
              InkResponse(
                  onTap: () => setColor(_colors[1]),
                  child: ColorButton(_colors[1])),
              InkResponse(
                  onTap: () => setColor(_colors[2]),
                  child: ColorButton(_colors[2])),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Choose image'),
              content: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return _images;
                  }
                  return _images.where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  setImage(selection);
                },
              ),
              actions: <Widget>[
                TextButton(
                    child: Text('Change'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}

class ColorButton extends StatelessWidget {
  final int colorCode;
  const ColorButton(this.colorCode, {super.key});
  @override
  Widget build(BuildContext context) {
   return Container(
     width: 80,
     height: 50,
     decoration:BoxDecoration(
       border: Border.all(color: Colors.black, width: 3),
       borderRadius: BorderRadius.all(Radius.circular(16)),
       color: Color(colorCode)
     )

   );
  }
}
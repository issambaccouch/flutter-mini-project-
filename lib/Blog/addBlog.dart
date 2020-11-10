import 'package:flutter/material.dart';
import 'package:flutter_app/NetworkHandler.dart';
import 'package:flutter_app/Pages/HomePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_select/smart_select.dart';
import 'package:flutter/services.dart';

class AddBlog extends StatefulWidget {
  AddBlog({Key key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  TextEditingController _petameController = TextEditingController();
  TextEditingController _petageController = TextEditingController();
  TextEditingController _petdescController = TextEditingController();

  String _race = '' ;
  String _sex = '' ;
  String _status = '' ;

  List<S2Choice<String>> pet_racechoices = [
    S2Choice<String>(value: 'cat', title: 'Cat'),
    S2Choice<String>(value: 'dog', title: 'Dog'),
    S2Choice<String>(value: 'bunnie', title: 'Bunnie'),
    S2Choice<String>(value: 'hamster', title: 'Hamster'),
  ];
  List<S2Choice<String>> pet_sexchoices = [
    S2Choice<String>(value: 'male', title: 'Male'),
    S2Choice<String>(value: 'female', title: 'Female'),
  ];

  List<S2Choice<String>> pet_statuschoices = [
    S2Choice<String>(value: 'lost', title: 'Lost'),
    S2Choice<String>(value: 'adoption', title: 'Adoption'),
  ];


  NetworkHandler nh = NetworkHandler();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();
  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  IconData iconphoto = Icons.image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
    child : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
        ],
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          children: <Widget>[
            titleTextField(),
            pet_nameTextField(),
            pet_ageTextField(),
            Expanded(child:  pet_raceTextField()),
            Expanded(child:  pet_statusTextField()),
            Expanded(child:  pet_sexTextField()),
            pet_descTextField(),
            SizedBox(
              height: 20,
            ),
            addButton(),
          ],
        ),
      ),
    ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _title,
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return "Title can't be empty";
        //   } else if (value.length > 100) {
        //     return "Title length should be <=100";
        //   }
        //   return null;
        // },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Add Image and Title",
          prefixIcon: IconButton(
            icon: Icon(
              iconphoto,
              color: Colors.teal,
            ),
            onPressed: takeCoverPhoto,
          ),
        ),
        maxLines: 3,
      ),
    );
  }
  Widget pet_nameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _petameController,
        validator: (value) {
          if (value.isEmpty) {
            return "can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide name for your Pet",
        ),
        maxLines: null,
      ),
    );
  }
  Widget pet_ageTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,

      ),
      child: TextFormField(
        controller: _petageController,
        validator: (value) {
          if (value.isEmpty) {
            return "can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide age to your Pet ",
        ),
        maxLines: null,
      ),
    );
  }
  Widget pet_raceTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: SmartSelect<String>.single(
        title: 'Race',
        value: _race,
        choiceItems: pet_racechoices,
        onChange: (state) => setState(() => _race = state.value),
        modalType: S2ModalType.popupDialog,
        choiceType: S2ChoiceType.chips,
        choiceStyle: S2ChoiceStyle(
          color: Colors.blueGrey[400],
          brightness: Brightness.dark,
        ),
        tileBuilder: (context, state) => S2Tile.fromState(
          state,
          isTwoLine: true,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.pets),
          ),
        ),
      ),
    );
  }
  Widget pet_statusTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: SmartSelect<String>.single(
        title: 'Status',
        value: _status,
        choiceItems: pet_statuschoices,
        onChange: (state) => setState(() => _status = state.value),
        modalType: S2ModalType.popupDialog,
        choiceType: S2ChoiceType.chips,
        choiceStyle: S2ChoiceStyle(
          color: Colors.blueGrey[400],
          brightness: Brightness.dark,
        ),
        tileBuilder: (context, state) => S2Tile.fromState(
          state,
          isTwoLine: true,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.find_replace),
          ),
        ),
      ),
    );
  }
  Widget pet_sexTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: SmartSelect<String>.single(
        title: 'Gender',
        value: _sex,
        choiceItems: pet_sexchoices,
        onChange: (state) => setState(() => _sex = state.value),
        modalType: S2ModalType.popupDialog,
        choiceType: S2ChoiceType.chips,
        choiceStyle: S2ChoiceStyle(
          color: Colors.blueGrey[400],
          brightness: Brightness.dark,
        ),
        tileBuilder: (context, state) => S2Tile.fromState(
          state,
          isTwoLine: true,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.add_circle),
          ),
        ),
      ),
    );
  }
  Widget pet_descTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _petdescController,
        validator: (value) {
          if (value.isEmpty) {
            return "can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide description for your Pet ",
        ),
        maxLength: 100,
        maxLines: 3,
      ),
    );
  }
  Widget addButton() {
    return InkWell(
      onTap: () async {
        Map<String, String> data = {
          "pet_name": _petameController.text,
          "pet_age":  _petageController.text,
          "pet_desc": _petdescController.text,
          "pet_race": _race,
          "pet_sex": _sex,
          "pet_status": _status,
        };
        var response =
        await  nh.addpet(data["pet_name"], data["pet_race"], data["pet_age"], data["pet_status"], data["pet_desc"], data["pet_sex"]);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
                  (route) => false);
        }
        else {
          Fluttertoast.showToast(
              msg: "Please verify your informations ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal),
          child: Center(
              child: Text(
            "Add Pet",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/UI/data.dart';
import 'package:flutter_app/UI/pet_widget.dart';

class CategoryList extends StatelessWidget {

String category ;
 List<Pet>pets ;

  CategoryList({@required this.category,this.pets});
  var selected = true ;


@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          (category == "HAMSTER" ? "Hamster" : category == "CAT" ? "Cat" : category == "BUNNY" ? "Bunny" : "Dog") + " Category",
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildFilter("Adoption", selected),
                buildFilter("Disappear", selected),

              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                childAspectRatio: 1 / 1.55,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                children: pets.where((i) => i.pet_race.toUpperCase() == category).map((item) {
                  return PetWidget(
                    pet: item,
                    index: null,
                  );
                }).toList(),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildFilter(String name, bool selected) {
    return InkWell(child: Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),

        ),

        border: Border.all(
          width: 1,
          color: selected ? Colors.transparent : Colors.grey[300],
        ),
        boxShadow: [
          BoxShadow(
            color: selected ? Colors.blue[300].withOpacity(0.5) : Colors.white,
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
        color: selected ? Colors.blue[300] : Colors.white,
      ),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.grey[800],
            ),
          ),

          selected
              ? Row(
            children: [

              SizedBox(
                width: 8,
              ),

              Icon(
                Icons.clear,
                color: Colors.white,
                size: 18,
              ),

            ],
          )
              : Container(),
        ],
      ),
    ),
      onTap: () {
        changeStatus(this.selected);
        print(this.selected) ;
        Container();
      },
    );
  }


void changeStatus(selected) {
  if (selected == true) {
    this.selected = false;
  }else {
    this.selected = true;
  }

}

}
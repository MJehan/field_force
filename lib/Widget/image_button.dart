import 'package:field_force/book/book1.dart';
import 'package:field_force/constrains/constrain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonImage extends StatelessWidget {
  String title ='';
  String path = '';
  ButtonImage({
    required this.title, required this.path,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.kInactiveColor,
      elevation: 8 ,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.black26,
        onTap: (){
          Navigator.pushNamed(context, Book1.id);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(image: AssetImage(path),
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 6,),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {

  ImageSlider({super.key, required this.img});
  final String img;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurStyle: BlurStyle.normal,
          )
        ],
        color:const Color.fromRGBO(116, 81, 45,1.0),

        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 5,
          color: Colors.black45,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 180,
          height: 200,
          decoration: BoxDecoration(
        color: const Color.fromRGBO(116, 81, 45,1.0),
            
            image: DecorationImage(
              image: NetworkImage(img), 
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

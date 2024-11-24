import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  
  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding:const EdgeInsets.all(25),
        decoration:BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),),
        child: const Center(
          child: Text("Sign in",
          style: TextStyle(color:Colors.white,
          fontWeight: FontWeight.bold,
          fontSize:16,
          ),
          )
        )
      ),
    );
  }
}
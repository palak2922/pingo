import 'package:flutter/material.dart';
import 'package:pingo/Widgets/custom_loader.dart';

class MyButton extends StatelessWidget {
  final bool isloading;
  final Function()? onTap;

  const MyButton({super.key, required this.onTap, required this.isloading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isloading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isloading ? CustomLoader(color: Colors.white, size: 20) : const Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

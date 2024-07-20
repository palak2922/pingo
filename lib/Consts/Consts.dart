import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



InputDecoration buildInputDecoration({String? hint, Function()? onTap, bool icon = false}) {
  return InputDecoration(
      errorMaxLines: 4,
      suffixIcon: onTap == null ? null : InkWell(
        onTap: onTap,
        child: Icon(
          icon
              ? Icons.remove_red_eye_outlined
              : Icons.remove_red_eye,
          color: Colors.black,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      fillColor: Colors.grey.shade200,
      filled: true,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[500])
  );
}


var newFormat = DateFormat("yyyy-MM-dd");

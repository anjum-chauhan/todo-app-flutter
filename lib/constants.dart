import 'package:flutter/material.dart';

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black12,
      width: 1.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black38,
      width: 1.0,
    ),
  ),
);

const kIconCompleted = Icon(
  Icons.done,
);

const kIconNotCompleted = Icon(
  Icons.clear,
);

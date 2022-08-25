import 'package:flutter/material.dart';

Widget originalTextFeild({
           required String  labeltext,
           required TextEditingController controller,
          })=>
    TextFormField(
     controller: controller,
     decoration: InputDecoration(
     labelText:'$labeltext '
     ),
    );
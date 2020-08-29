import 'package:flutter/material.dart';

class ConstantFile {
  final String baseUrl =  "http://192.168.43.159/absenudacoding/index.php/Api/";
  final String imageUrl = "http://192.168.43.159/absenudacoding/image/";
}

progressDialog(BuildContext context) {
  showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black45.withOpacity(0.65),
      context: context,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => Center(
            child: CircularProgressIndicator(),
          ));
}

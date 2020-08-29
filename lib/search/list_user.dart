import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/model/ModelUser.dart';
import 'package:flutter/material.dart';

class ListUser extends StatelessWidget {
  List list;
  ListUser({this.list});
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return GridView.builder(
        shrinkWrap: true,
        //scrollDirection: Axis.horizontal,
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0, //MENGATUR JARAK ANTARA OBJEK ATAS DAN BAWAH
          crossAxisSpacing: 3, //MENGATUR JARAK ANTARA OBJEK KIRI DAN KANAN
          childAspectRatio: 0.8, //ASPEK RASIONYA KITA SET BANDING 1 SAJA
        ),
        itemBuilder: (context, index) {
          Datum data = list[index];
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            elevation: 10.0,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Image.network(
                          ConstantFile().imageUrl + data.photoUser,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        data?.fullnameUser ?? "",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        data?.phoneUser ?? "",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        data?.emailUser ?? "",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        });
  }


}

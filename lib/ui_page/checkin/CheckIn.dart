import 'dart:async';

import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/model/ModelAbsent.dart';
import 'package:absent_udacoding/network/NetworkProvider.dart';
import 'package:absent_udacoding/ui_page/profile/DetailProfile.dart';
import 'package:absent_udacoding/utils/SessionManager.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckIn extends StatefulWidget {
  TabController controller;
  CheckIn(this.controller);

  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  BaseEndPoint network = NetworkProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: network.getAbsent(""),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? CheckinList(list: snapshot.data, controller: widget.controller)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class CheckinList extends StatefulWidget {
  List<Absent> list;
  TabController controller;
  CheckinList({this.list, this.controller});

  @override
  _CheckinListState createState() => _CheckinListState();
}

class _CheckinListState extends State<CheckinList> {

  GlobalKey<FormState> _key = GlobalKey();
  BaseEndPoint network = NetworkProvider();
  var sesion = SessionManager();
  var locAddress;
  String address1 = "";
  String address2 = "";

  LatLng myLocation;
  Timer _timer;
  Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _marker = {};
  double a, b;


  void getCurrentLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _marker.clear();
      final myMarker = Marker(
          markerId: MarkerId("My Position"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(title: "My Alamat" ));
      _marker['Current Location'] = myMarker;
      myLocation = LatLng(currentLocation.latitude, currentLocation.longitude);

    });

    print("Lat : ${currentLocation.latitude}");
    print("Lon : ${currentLocation.longitude}");

    final coordinate = new Coordinates(
        currentLocation.latitude, currentLocation.longitude);
    locAddress = await Geocoder.local.findAddressesFromCoordinates(coordinate);

    setState(() {
      address1 = locAddress.first.featureName;
      address2 = locAddress.first.addressLine;
    });
    /*print("${first.featureName} : ${first.addressLine}");*/

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    widget.list = widget.list.where((absent) {
      if (absent.checkIn == null)
        return true;
      else
        return false;
    }).toList();

    print(widget.list);
    return Container(
      child: Container(
        margin: EdgeInsets.all(8),
        child: GridView.builder(
            shrinkWrap: true,
            //scrollDirection: Axis.horizontal,
            itemCount: widget.list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0, //MENGATUR JARAK ANTARA OBJEK ATAS DAN BAWAH
              crossAxisSpacing: 3, //MENGATUR JARAK ANTARA OBJEK KIRI DAN KANAN
              childAspectRatio: 0.65, //ASPEK RASIONYA KITA SET BANDING 1 SAJA
            ),
            itemBuilder: (context, index) {
              Absent data = widget.list[index];
              // Role dataa = list[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailProfile(data: data)));
                },
                child: Card(
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
                              data?.nameRole ?? "",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(top: 16),
                              height: 45,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                textColor: Colors.white,
                                child: Text("Checkin"),
                                color: Colors.green,
                                onPressed: () => dialogCheckin(context, data),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  dialogCheckin(context, Absent data) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Are You Checkin Today ?",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 45,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            textColor: Colors.white,
                            color: Colors.green,
                            child: Text("Yes"),
                            onPressed: () async {
                              await sesion.getPreference();
                              var idUser = data.idUser;
                              var idCheckInBy = sesion.globIduser;
                              var place = address2;
                              await network.checkIn(idUser, idCheckInBy, place);
                              widget.controller.animateTo(1);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          height: 45,
                          child: OutlineButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusColor: Colors.green,
                            textColor: Colors.green,
                            borderSide: BorderSide(color: Colors.green),
                            child: Text("No"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}






class ListCheckIn extends StatelessWidget {
  GlobalKey<FormState> _key = GlobalKey();
  BaseEndPoint network = NetworkProvider();
  var sesi = SessionManager();
  List<Absent> list;
  TabController controller;
  ListCheckIn({this.list, this.controller});

  @override
  Widget build(BuildContext context) {
    list = list.where((absent) {
      if (absent.checkIn == null)
        return true;
      else
        return false;
    }).toList();

    print(list);
    return Container(
      child: Container(
        margin: EdgeInsets.all(8),
        child: GridView.builder(
            shrinkWrap: true,
            //scrollDirection: Axis.horizontal,
            itemCount: list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0, //MENGATUR JARAK ANTARA OBJEK ATAS DAN BAWAH
              crossAxisSpacing: 3, //MENGATUR JARAK ANTARA OBJEK KIRI DAN KANAN
              childAspectRatio: 0.65, //ASPEK RASIONYA KITA SET BANDING 1 SAJA
            ),
            itemBuilder: (context, index) {
              Absent data = list[index];
              // Role dataa = list[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailProfile(data: data)));
                },
                child: Card(
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
                              data?.nameRole ?? "",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(top: 16),
                              height: 45,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                textColor: Colors.white,
                                child: Text("Checkin"),
                                color: Colors.green,
                                onPressed: () => dialogCheckin(context, data),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

    dialogCheckin(context, Absent data) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Are You Checkin Today ?",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 45,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            textColor: Colors.white,
                            color: Colors.green,
                            child: Text("Yes"),
                            onPressed: () async {
                              await sesi.getPreference();
                              var idUser = data.idUser;
                              var idCheckInBy = sesi.globIduser;
                              var place = 'Solok';
                              await network.checkIn(idUser, idCheckInBy, place);
                              controller.animateTo(1);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          height: 45,
                          child: OutlineButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusColor: Colors.green,
                            textColor: Colors.green,
                            borderSide: BorderSide(color: Colors.green),
                            child: Text("No"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

//  Widget dataOld(Absent data, context) {
//    return Stack(
//      children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.only(top: 10, left: 25, right: 30),
//          child: Container(
//            height: 100.0,
//            width: 100.0,
//            decoration: BoxDecoration(
//                shape: BoxShape.circle,
//                image: DecorationImage(
//                    image: NetworkImage(
//                      ConstantFile().imageUrl + data.photoUser,
//                    ),
//                    fit: BoxFit.cover)),
//          ),
//        ),
//        Padding(
//          padding: const EdgeInsets.only(top: 120.0, left: 35.0),
//          child: Container(
//            height: 100,
//            width: 100,
//            child: Text(
//              data.fullnameUser,
//              style: TextStyle(
//                fontSize: 15.0,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//          ),
//        ),
//        Padding(
//          padding: const EdgeInsets.only(top: 160.0, left: 30.0),
//          child: Container(
//            height: 30.0,
//            child: Text(
//              data.nameRole,
//              style: TextStyle(
//                fontSize: 15.0,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//          ),
//        ),
//        Padding(
//          padding: const EdgeInsets.only(top: 190, left: 20),
//          child: RaisedButton(
//            color: Colors.green,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(20),
//            ),
//            child: SizedBox(
//                height: 50,
//                width: 80,
//                child: Padding(
//                  padding: const EdgeInsets.only(top: 10),
//                  child: Text(
//                    'Check In',
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                  ),
//                )),
//            onPressed: () {
//              showDialog(
//                  context: context,
//                  builder: (context) {
//                    return Center(
//                      child: AlertDialog(
//                        content: Container(
//                          height: 100,
//                          child: Center(
//                            child: Text(
//                              'Are You Want Check In Today ?',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold, fontSize: 20),
//                            ),
//                          ),
//                        ),
//                        actions: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Padding(
//                                padding: const EdgeInsets.only(left: 10),
//                                child: SizedBox(
//                                  child: RaisedButton(
//                                    child: Text('Yes'),
//                                    color: Colors.green,
//                                    shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(15),
//                                    ),
//                                    onPressed: () async {
//                                      var sesi = SessionManager();
//                                      await sesi.getPreference();
//                                      var idUser = data.idUser;
//                                      var idCheckInBy = sesi.globIduser;
//                                      var place = 'Solok';
//
//                                      await network.checkIn(
//                                          idUser, idCheckInBy, place);
//                                      controller.animateTo(1);
//                                      Navigator.pop(context);
//                                    },
//                                  ),
//                                  height: 50,
//                                  width: 120,
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(20),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(right: 20),
//                                child: SizedBox(
//                                  child: RaisedButton(
//                                    child: Text('No'),
//                                    shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(15),
//                                    ),
//                                    onPressed: () {
//                                      Navigator.pop(context);
//                                    },
//                                  ),
//                                  height: 50,
//                                  width: 120,
//                                ),
//                              ),
//                            ],
//                          )
//                        ],
//                      ),
//                    );
//                  });
//            },
//          ),
//        )
//      ],
//    );
//  }


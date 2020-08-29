import 'package:absent_udacoding/search/SearchPage.dart';
import 'package:flutter/material.dart';
import 'ui_page/checkin/CheckIn.dart' as tabcheckin;
import 'ui_page/checkout/CheckOut.dart' as tabcheckout;

class DashboardAbsen extends StatefulWidget {
  @override
  _DashboardAbsenState createState() => _DashboardAbsenState();
}

class _DashboardAbsenState extends State<DashboardAbsen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Search User', style: TextStyle(
                        fontSize: 18,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                       Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              text: 'Check In',
            ),
            Tab(
              text: 'Check Out',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          tabcheckin.CheckIn(controller),
          tabcheckout.CheckOut(),
        ],
      ),
    );
  }
}

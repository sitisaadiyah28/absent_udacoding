import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/model/ModelAbsent.dart';
import 'package:absent_udacoding/model/ModelRole.dart';
import 'package:absent_udacoding/model/ModelUser.dart';
import 'package:absent_udacoding/search/list_user.dart';
import 'package:absent_udacoding/ui_page/checkin/CheckIn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = new TextEditingController();
  bool _isSearch = true;
  List filterList;

  List finalData;
  String keyword;


  Future<List<Datum>> getSearch() async{
    final response = await http.post(ConstantFile().baseUrl + "searchUser", body: {
      'keyword' : searchController.text
    });

    ModelUser data = modelUserFromJson(response.body);
    return data.data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _SearchPageState() {
    searchController.addListener(() {
      if(searchController.text.isEmpty){
        setState(() {
          _isSearch = true;
          keyword = "";
        });
      }
      else {
       setState(() {
         _isSearch = false;
         keyword = searchController.text;
       });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _createSearchView(),
          _isSearch ? _createListView() : perfomSearch(),
        ],
      ),
    );
  }

  Widget _createSearchView() {
    return Card(
      margin: EdgeInsets.only(top: 8),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: searchController,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: "Search User"
          ),
        ),
      ),
    );
  }

  Widget _createListView(){
    return Flexible(
      child: FutureBuilder(
        future:  getSearch(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ListUser(
            list: snapshot.data,
          )
              : new Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget perfomSearch(){
    return Flexible(
      child: FutureBuilder(
        future:  getSearch(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ListUser(
            list: snapshot.data,
          )
              : new Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}



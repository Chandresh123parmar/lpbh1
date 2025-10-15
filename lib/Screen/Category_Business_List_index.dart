/*
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:lpbh1/Api/API_Service.dart';
import 'package:lpbh1/Model/Category_Business_ListModel.dart';
import 'package:http/http.dart' as http;

class CategoryBusinessListIndex extends StatefulWidget {
  final String cat_Id;
  const CategoryBusinessListIndex({super.key, required this.cat_Id});

  @override
  State<CategoryBusinessListIndex> createState() => _CategoryBusinessListIndexState();
}

class _CategoryBusinessListIndexState extends State<CategoryBusinessListIndex> {

  @override
  void initState() {
    super.initState();
    businessList();
  }

  //final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Category Businesses',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          actions: [
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.add,size: 27,))
          ],
        ),

        body: FutureBuilder<CategoryBusinessListModel>(
          future: businessList(),
          builder:  (context, snap) {
            final category = snap.data!.data!;
            return Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: TextField(
                    controller: SearchController(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade200,width: 7)
                      ),
                      hintText: 'Search for Businesses',
                      prefixIcon: Icon(Icons.search,color: Colors.grey.shade500,),
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: category.length,
                      itemBuilder: (context, index){
                      final list = category[index];
                      return InkWell(
                        onTap: (){},
                        child: Card(
                          child: ListTile(
                            leading: Image.network(list.bussinessCard.toString()),
                            title: Text(list.bussinessName.toString()),
                          )
                        ),
                      );

                      }),
                )
              ],
            );

          },
        ),
      ),
    );
  }

  Future<CategoryBusinessListModel> businessList()async{
    final response = await http.post(Uri.parse(ApiUrl.category_Business_List));
    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      return CategoryBusinessListModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load category list');
    }

  }
}
*/

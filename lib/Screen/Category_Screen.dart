import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lpbh1/Screen/Category_Business_List_index.dart';
import '../Api/API_Service.dart';
import '../Model/Category_List_Model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {


  @override
  void initState() {
    super.initState();
    categoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Category',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: FutureBuilder<CategoryListModel>(
        future: categoryList(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }  else {
            final category = snap.data!.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: category.length,
              itemBuilder: (context, index) {
                final list = category[index];
                return InkWell(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryBusinessListIndex(cat_Id: list.id.toString() ??'0',)));
                  },
                  child: Card(
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Circle Image
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade50,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(list.icon ?? '',),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Category Name
                        Text(
                          list.name ?? 'No Name',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<CategoryListModel> categoryList() async {
    final response = await http.get(Uri.parse(ApiUrl.category_List));
    if (response.statusCode == 200) {
      print(response.body);
      return CategoryListModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load category list');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'food_page.dart';
import 'home_page.dart';
import 'list_orderActive.dart';
import 'product_model.dart';

class FavoritePage extends StatefulWidget {
  final String token;
  final String accountID;

  const FavoritePage({
    Key? key,
    required this.token,
    required this.accountID,
  }) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Product> _favoriteProducts = [];
  Set<String> _removedProductIds = Set(); // Track removed products by their IDs

  @override
  void initState() {
    super.initState();
    _fetchFavoriteProducts();
  }

  Future<void> _fetchFavoriteProducts() async {
    print('Fetching favorite products for accountID: ${widget.accountID}'); // Debug print
    final uri = Uri.parse('https://huflit.id.vn:4321/api/Product/getListByCatId?categoryID=4229&accountID=${widget.accountID}');
    final request = http.MultipartRequest('GET', uri)
      ..headers['Authorization'] = 'Bearer ${widget.token}';

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody'); // Debug print
        List<dynamic> data = json.decode(responseBody);
        setState(() {
          _favoriteProducts = data.map((item) => Product.fromJson(item)).toList();
        });
      } else {
        print('Failed to load favorite products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }


  Future<void> _deleteProduct(int productId) async {
    try {
      final uri = Uri.parse('https://huflit.id.vn:4321/api/removeProduct');
      final request = http.MultipartRequest('DELETE', uri)
        ..headers['Authorization'] = 'Bearer ${widget.token}'
        ..fields['productId'] = productId.toString()
        ..fields['accountID'] = widget.accountID;

      final response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          _favoriteProducts.removeWhere((product) => product.id == productId);
          _removedProductIds.remove(productId.toString()); // Đảm bảo kiểu dữ liệu phù hợp
        });
      } else {
        print('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change background to white
      appBar: AppBar(
        title: Text('Món yêu thích', textAlign: TextAlign.center), // Updated title
        backgroundColor: Color(0xFFF5CB58),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(token: widget.token, accountID: widget.accountID,)),
            );
          },
        ),
      ),
      body: _favoriteProducts.isEmpty
          ? Center(child: Text('No favorite products'))
          : ListView.builder(
        itemCount: _favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = _favoriteProducts[index];
          final isRemoved = _removedProductIds.contains(product.id.toString());

          return Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListTile(
              leading: Image.network(product.imageURL, width: 50, height: 50),
              title: Text(product.name),
              subtitle: Text('${product.price.toStringAsFixed(3)}đ'),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isRemoved ? Colors.grey : Colors.red,
                ),
                onPressed: () {
                  if (!isRemoved) {
                    // Cập nhật trạng thái ngay lập tức để thay đổi màu sắc của trái tim
                    setState(() {
                      _removedProductIds.add(product.id.toString());
                    });

                    // Thực hiện việc xóa sản phẩm sau 1 giây
                    Future.delayed(Duration(seconds: 1), () {
                      _deleteProduct(product.id);
                    });
                  }
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)), // Rounds top corners
        child: BottomAppBar(
          color: Color(0xFFFE5621),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(token: widget.token, accountID: widget.accountID,)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.restaurant, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FoodPage(token: widget.token, accountID: widget.accountID,)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage(token: widget.token, accountID: widget.accountID)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.shopping_bag, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ListOrder(token: widget.token, accountID: widget.accountID,)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

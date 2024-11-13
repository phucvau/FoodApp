import 'package:flutter/material.dart';
import 'package:doan_ver2/product_service.dart';
import 'package:doan_ver2/product_model.dart';
import 'package:badges/badges.dart' as badges;
import 'cart_item.dart';
import 'detailProduct_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'list_orderActive.dart';
import 'navbar.dart';



class FoodPage extends StatefulWidget {
  final String token;
  final String accountID;

  const FoodPage({Key? key, required this.token, required this.accountID}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> _productsFuture;
  List<CartItem> _cart = [];
  int _selectedCategoryId = 0; // Sử dụng biến này để lưu trữ danh mục đã chọn
  bool _isNavbarVisible = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    if (_selectedCategoryId == 0) {
      _productsFuture = _productService.fetchProducts(widget.token);
    } else {
      _productsFuture = _productService.fetchProductsByCategory(widget.token, _selectedCategoryId);
    }
  }

  void _viewAllProduct() {
    _onCategorySelected(0);
  }

  void _addToCart(Product product, int quantity) {
    setState(() {
      CartItem? existingItem = _cart.firstWhere(
            (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product, quantity: 0),
      );
      if (existingItem.quantity == 0) {
        _cart.add(existingItem);
      }
      existingItem.quantity += quantity; // Cập nhật số lượng
    });
  }


  void _navigateToCart() {
    setState(() {
      _isNavbarVisible = !_isNavbarVisible; // Toggle visibility
    });
  }
  void _hideNavbar() {
    setState(() {
      _isNavbarVisible = false;
    });
  }

  void _onCategorySelected(int categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      _loadProducts();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CB58),
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: badges.Badge(
              badgeContent: Text(
                _cart.fold<int>(
                    0, (previousValue, item) => previousValue + item.quantity
                ).toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(Icons.shopping_cart, color: Colors.orange),
            ),
            onPressed: _navigateToCart,
          ),
          SizedBox(width: 10),
          Icon(Icons.notifications, color: Colors.orange),
          SizedBox(width: 10),
        ],
      ),
    body: GestureDetector(
    onTap: () {
    if (_isNavbarVisible) {
    _hideNavbar();
    }
    },
    child: Stack(
        children: [
          Container(
            color: Color(0xFFF5CB58),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCategoryIcon(Icons.fastfood, 'Thức Ăn Nhanh', 3964),
                        _buildCategoryIcon(Icons.restaurant, 'Thịt', 3961),
                        _buildCategoryIcon(Icons.eco, 'Khai Vị', 3959),
                        _buildCategoryIcon(Icons.cake, 'Tráng Miệng', 3962),
                        _buildCategoryIcon(Icons.local_drink, 'Nước', 3963),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildSectionTitle('Danh sách món ăn', () {
                      // Navigate to Recommend page
                    }),
                    SizedBox(height: 8),
                    _buildRecommendList(),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            right: _isNavbarVisible ? 0 : -330,
            top: 0,
            bottom: 0,
            child: Navbar(
              rightPosition: _isNavbarVisible ? 0 : -330,
              cartItems: _cart, token: widget.token, accountID: widget.accountID,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: _isNavbarVisible ? -80 : 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
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
                          MaterialPageRoute(builder: (context) =>
                              HomePage(token: widget.token, accountID: widget.accountID,)),
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
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildCategoryIcon(IconData iconData, String label, int categoryId) {
    return GestureDetector(
      onTap: () => _onCategorySelected(categoryId),
      child: Column(
        children: [
          Icon(iconData, size: 40, color: Colors.orange),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: GestureDetector(
            onTap: _viewAllProduct,
            child: Text(
              'View All',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70.0), // Thêm khoảng cách 40 đơn vị phía dưới
      child: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!;
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.05,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return _buildRecommendItem(products[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildRecommendItem(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: product,
              addToCart: (Product p, int qty) => _addToCart(p, qty), token: widget.token, // Truyền hàm callback với số lượng
            ),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.imageURL,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Center(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 55,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${product.price.toStringAsFixed(3)}đ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                    iconSize: 24,
                    onPressed: () {
                      // Gọi hàm _addToCart với số lượng là 1
                      _addToCart(product, 1);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

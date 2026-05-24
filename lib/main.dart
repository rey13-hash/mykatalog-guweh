import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Produk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductCatalogPage(),
    );
  }
}

class ProductCatalogPage extends StatelessWidget {
  const ProductCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Products',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      extendBodyBehindAppBar: true, 
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Colors.white,
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const SearchBarWidget(),
              const SizedBox(height: 20),
              const CategorySection(),
              const SizedBox(height: 24),
              const ProductHeaderSection(),
              const SizedBox(height: 16),
              const ProductGridSection(), // Memanggil seksi produk
            ],
          ),
        ),
      ),
    );
  }
}

// ================= WIDGET UI =================

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search men fashion...',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: Colors.blue),
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.checkroom, 'label': 'Tshirt'},
    {'icon': Icons.ice_skating, 'label': 'Shoes'}, 
    {'icon': Icons.shopping_bag, 'label': 'Bag'},
    {'icon': Icons.style, 'label': 'Dress'},
    {'icon': Icons.watch, 'label': 'Watch'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    categories[index]['icon'],
                    color: Colors.blue[700],
                    size: 28,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  categories[index]['label'],
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductHeaderSection extends StatelessWidget {
  const ProductHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '967 Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Based on your filter',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.view_list, color: Colors.grey), onPressed: () {}),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.grid_view, color: Colors.blue),
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
    );
  }
}

// ================= GRIDS PRODUK (SUDAH DISELARASKAN DENGAN NAMA FILE KAMU) =================

class ProductGridSection extends StatefulWidget {
  const ProductGridSection({super.key});

  @override
  State<ProductGridSection> createState() => _ProductGridSectionState();
}

class _ProductGridSectionState extends State<ProductGridSection> {
  // Path di bawah ini disesuaikan dengan folder "images" dan format ".jpeg" asli milikmu
  final List<Map<String, String>> products = [
    {
      'image': 'assets/images/mint_sneakers.jpeg', 
      'title': 'Mint Leather Sneakers',
      'price': '\$212.5',
      'oldPrice': '\$250',
      'discount': '15%'
    },
    {
      'image': 'assets/images/white_sneakers.jpeg',
      'title': 'Classic White Sneakers',
      'price': '\$180.0',
      'oldPrice': '\$200',
      'discount': '10%'
    },
    {
      'image': 'assets/images/denim.jpeg', // <--- Menyesuaikan nama file denim.jpeg kamu
      'title': 'Dark Wash Denim Jacket',
      'price': '\$212.5',
      'oldPrice': '\$250',
      'discount': '15%'
    },
    {
      'image': 'assets/images/sport_watch.jpeg',
      'title': 'Urban Sport Watch',
      'price': '\$180.0',
      'oldPrice': '\$200',
      'discount': '10%'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < products.length; i += 2) {
      int index1 = i;
      int index2 = i + 1;

      rows.add(
        Row(
          children: [
            Expanded(
              child: ProductCard(product: products[index1]),
            ),
            const SizedBox(width: 16),
            if (index2 < products.length)
              Expanded(
                child: ProductCard(product: products[index2]),
              )
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      );
      rows.add(const SizedBox(height: 16));
    }

    return Column(children: rows);
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, String> product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              product['image']!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['title']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['price']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Text(
                          product['oldPrice']!,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        product['discount']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
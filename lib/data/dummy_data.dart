import 'package:shop/models/product.dart';

final List<Product> dummyProducts = [
  Product(
    id: 'p1',
    name: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageUrl:
        'assets/images/shirt.jpg',
  ),
  Product(
    id: 'p2',
    name: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imageUrl:
        'assets/images/trouses.jpg',
  ),
  Product(
    id: 'p3',
    name: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imageUrl: 'assets/images/yellowScarf.jpg',
  ),
  Product(
    id: 'p4',
    name: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl:
        'assets/images/pan.jpg',
  ),
];

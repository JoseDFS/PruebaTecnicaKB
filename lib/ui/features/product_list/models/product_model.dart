
import 'package:prueba_tecnica_kb/data/daos/product_dao.dart';

class ProductModel {
    final int id;
    final String title;
    final double price;
    final String description;
    final String category;
    final String image;
    final double rating;
    final int reviews;

    ProductModel({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rating,
        required this.reviews,
    });

    factory ProductModel.fromDao(ProductDao productDao) {
        return ProductModel(
            id: productDao.id,
            title: productDao.title,
            price: productDao.price,
            description: productDao.description,
            category: productDao.category,
            image: productDao.image,
            rating: productDao.rating.rate, // Usando solo la tasa de calificación
            reviews: productDao.rating.count,
        );
    }
}


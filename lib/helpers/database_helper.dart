import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:phone_auth/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String cartTable = 'Cart_table';
  String colId = 'id';
  String product_name = 'product_name';
  String product_quentity = 'product_quentity';
  String total_price = 'total_price';
  String per_unit_price = 'per_unit_price';

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'cart_list.db';
    final cartListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return cartListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $cartTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $product_name TEXT, $product_quentity INTEGER, $total_price DOUBLE, $per_unit_price DOUBLE)');
  }

  Future<List<Map<String, dynamic>>> getCartMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(cartTable);
    return result;
  }

  Future<List<Cart>> getCartList() async {
    final List<Map<String, dynamic>> cartMapList = await getCartMapList();
    final List<Cart> cartList = [];
    cartMapList.forEach((cartMap) {
      cartList.add(Cart.formMap(cartMap));
    });

    //cartList.sort((CartA, CartB) => CartA.date.compareTo(CartB.date));

    return cartList;
  }

  Future<int> insertCart(Cart Cart) async {
    Database db = await this.db;
    final int result = await db.insert(cartTable, Cart.toMap());
    return result;
  }

  Future<int> updateCart(Cart cart) async {
    Database db = await this.db;
    final int result = await db.update(cartTable, cart.toMap(),
        where: '$colId=?', whereArgs: [cart.id]);
    return result;
  }

  Future<int> deleteCart(int id) async {
    Database db = await this.db;
    final int result =
        await db.delete(cartTable, where: '$colId=?', whereArgs: [id]);
    return result;
  }
}

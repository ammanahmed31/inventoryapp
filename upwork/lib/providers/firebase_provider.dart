// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upwork/models/stock.dart';

class FirebaseProvider with ChangeNotifier {
  Stock _stock = Stock();
  bool _isLoading = false;

  Stock? get sotck => _stock;
  bool get isLoading => _isLoading;

  Future<void> getCurrentStock() async {
    _isLoading = true;
    notifyListeners();
    var db = FirebaseFirestore.instance;
    final ref = db.collection("inventory").doc("HHvxFebVhPemOa1LcEGl");
    ref.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        log('data: $data');
        _stock = Stock.fromJson(data['stock']);
        _stock.cheese = _stock.cheese / 1000;
        _stock.chicken = _stock.chicken / 1000;
        _stock.sauce = _stock.sauce / 1000;
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> makeChickenPizza(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    DocumentReference docRef = FirebaseFirestore.instance.collection('inventory').doc('HHvxFebVhPemOa1LcEGl');
    DocumentSnapshot snapshot = await docRef.get();
    log('inventory: ${snapshot.data() ?? 'null'}');
    Map<String, dynamic> inventory = snapshot.data() as Map<String, dynamic>;
    log('inventory: $inventory');
    if ((inventory['stock']['chicken'] - 400) < 0) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sorry out of ingredients')));
    } else {
      Map<String, dynamic> newInventory = {
        'pizza_base': inventory['stock']['pizza_base'] - 1,
        'chicken': inventory['stock']['chicken'] - 400,
        'sauce': inventory['stock']['sauce'] - 100,
        'cheese': inventory['stock']['cheese'] - 200,
      };
      Map<String, dynamic> newMapToUpdate = {'stock': newInventory};
      await docRef.update(newMapToUpdate);
      await getCurrentStock();
    }
  }
}

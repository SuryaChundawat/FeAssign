



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletProvider with ChangeNotifier {
  double _balance = 500.00;
  bool _isHidden = false;
  List<Map<String, dynamic>> _transactions = [];

  WalletProvider();

  double get balance => _balance;
  bool get isHidden => _isHidden;
  List<Map<String, dynamic>> get transactions => _transactions;

  void toggleBalanceVisibility() {
    _isHidden = !_isHidden;
    notifyListeners();
  }

  void sendMoney(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      _transactions.add({'amount': amount, 'date': DateTime.now().toString()});
      notifyListeners();
    }
  }

  Future<void> fetchTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedTransactions = prefs.getString('transactions');
    if (storedTransactions != null) {
      _transactions = List<Map<String, dynamic>>.from(jsonDecode(storedTransactions));
    }
    notifyListeners();
  }

  Future<void> saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('transactions', jsonEncode(_transactions));
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/wallet_provider.dart';



class SendMoneyScreen extends StatefulWidget {
  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();

  void _submitAmount(WalletProvider wallet) {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      _showBottomSheet("Invalid amount", Colors.red);
      return;
    }
    if (amount > wallet.balance) {
      _showBottomSheet("Insufficient balance", Colors.red);
      return;
    }
    wallet.sendMoney(amount);
    wallet.saveTransactions();
    _showBottomSheet("Transaction successful", Colors.green);
    _amountController.clear();
  }

  void _showBottomSheet(String message, Color color) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        color: color,
        height: 50,
        child: Center(child: Text(message, style: TextStyle(color: Colors.white))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Send Money")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter amount"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submitAmount(wallet),
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
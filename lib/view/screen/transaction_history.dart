

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/wallet_provider.dart';



class TransactionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Transaction History")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wallet.transactions.isEmpty
            ? Center(child: Text("No transactions yet."))
            : ListView.builder(
          itemCount: wallet.transactions.length,
          itemBuilder: (_, index) {
            final transaction = wallet.transactions[index];
            return ListTile(
              title: Text("₹ ${transaction['amount'].toStringAsFixed(2)}"),
              subtitle: Text(transaction['date']),
            );
          },
        ),
      ),
    );
  }
}
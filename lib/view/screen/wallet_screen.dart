


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/wallet_provider.dart';
import 'login_screen.dart';
import 'send_money.dart';
import 'transaction_history.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Wallet Balance: ", style: TextStyle(fontSize: 20)),
                Row(
                  children: [
                    Text(wallet.isHidden ? "******" : "₹ ${wallet.balance.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 20)),
                    IconButton(
                      icon: Icon(wallet.isHidden ? Icons.visibility : Icons.visibility_off),
                      onPressed: wallet.toggleBalanceVisibility,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SendMoneyScreen()),
              ),
              child: Text("Send Money"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
              ),
              child: Text("View Transactions"),
            ),
          ],
        ),
      ),
    );
  }
}
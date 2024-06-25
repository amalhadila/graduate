import 'package:flutter/material.dart';

class SendPriceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Send Price'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tour ID: ', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Enter Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to send the price will be implemented here
                print('Price: ${priceController.text}');
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}

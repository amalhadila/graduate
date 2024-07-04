import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';

class OtherMessage extends StatelessWidget {
  final String message;

  OtherMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text('B', style: TextStyle(fontWeight: FontWeight.w700,color:kbackgroundcolor),), backgroundColor: ksecondcolor),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Bot", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(59, 112, 114, 186),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(message),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
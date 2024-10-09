import 'package:flutter/material.dart';

class TransportPage extends StatelessWidget { // Public class without underscore
  const TransportPage({super.key}); // Converted 'key' to a super parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport Page'),
      ),
      body: const Center(
        child: Text('This is the Transport Page'),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class PermissionDenied extends StatelessWidget {
  const PermissionDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("你沒有權限"));
  }
}

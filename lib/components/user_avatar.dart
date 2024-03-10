import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final String path;

  const UserAvatar({super.key, this.size = 20, required this.path});

  @override
  Widget build(BuildContext context) {
    return //allows border radius
        ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(100),
      ),
      child: Image.network(
        path,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

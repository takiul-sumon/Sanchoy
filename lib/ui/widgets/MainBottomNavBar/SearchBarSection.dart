

import 'package:flutter/material.dart';

class SearchBarSection extends StatelessWidget {
  final TextEditingController controller;

  const SearchBarSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "খোঁজ (মোবাইল নম্বর)",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (_) => {},
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {},
              color: Colors.grey,
              icon: Image.asset('assets/icons/Filter.png'),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {},
              color: Colors.grey,
              icon: Image.asset('assets/icons/Download Icon.png'),
            ),
          ),
        ],
      ),
    );
  }
}

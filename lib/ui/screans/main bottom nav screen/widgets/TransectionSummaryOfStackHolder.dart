
import 'package:flutter/material.dart';

class TransectionSummaryofStakeholder extends StatelessWidget {
  const TransectionSummaryofStakeholder({
    super.key,
    required this.supplierDue,
    required this.customerDue,
  });

  final double supplierDue;
  final double customerDue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text(
              "মোট পাবে",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              "৳$supplierDue",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
          width: 40,
        ),
        Column(
          children: [
            const Text(
              "মোট দেবে",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              "৳$customerDue",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


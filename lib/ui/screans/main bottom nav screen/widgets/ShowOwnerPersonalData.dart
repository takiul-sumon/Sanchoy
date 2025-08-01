import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanchoy/data/models/app_user.dart';

class ShowOwnerPersonalData extends StatelessWidget {
  const ShowOwnerPersonalData({
    super.key,
    required this.fetchUserPersonalData,
    required this.date,
    required this.ontap,
  });

 final List<AppUser> fetchUserPersonalData;
  final DateTime date;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: ontap,
              child: Text(
                fetchUserPersonalData.isNotEmpty
                    ? '${fetchUserPersonalData[0].firstName} ${fetchUserPersonalData[0].lastName}'
                    : '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              DateFormat.yMMMEd().format(date),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Image.asset('assets/icons/Language Switch.png'),
            ),
            const SizedBox(width: 6),
            IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Image.asset('assets/icons/Notification Icon Container.png'),
            ),
          ],
        ),
      ],
    );
  }
}

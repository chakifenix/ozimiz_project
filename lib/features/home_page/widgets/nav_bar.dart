import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 0,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, -4), // Вертикальное смещение
                spreadRadius: 0, // Распространение тени (ширина)
                blurRadius: 7.r, // Радиус размытия
              ),
            ],
            borderRadius: BorderRadius.circular(20.r)),
        child: Row(
          children: [
            navItem(
              Icons.home_outlined,
              pageIndex == 0,
              onTap: () => onTap(0),
            ),
            SizedBox(
              width: 100,
            ),
            navItem(
              Icons.person,
              pageIndex == 1,
              onTap: () => onTap(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: selected ? Colors.red : Colors.black,
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:go_router/go_router.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Icon? icono;

  const CustomAppbar({super.key, this.icono});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0.16),

      leading: context.canPop()
          ? IconButton(
              onPressed: () => context.pop(),
              icon: icono ?? const Icon(Icons.arrow_back_ios_new),
            )
          : null,

      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF26A69A).withOpacity(0.65),
                  const Color(0xFF006064).withOpacity(0.50),
                  const Color(0xFF37474F).withOpacity(0.45),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.45),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),

      iconTheme: const IconThemeData(color: Colors.blueGrey),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

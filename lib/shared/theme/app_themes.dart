import 'package:event_booking/shared/theme/app_colors.dart';
import 'package:event_booking/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  // static final Color primaryColor = const Color(0xFF08B3E5);
  // static final Color secondaryColor = const Color(0xFF2BB673);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1.copyWith(
        color: AppColors.textPrimary,
      ),

      headlineMedium: AppTextStyles.heading2.copyWith(
        color: AppColors.textPrimary,
      ),

      headlineSmall: AppTextStyles.heading3.copyWith(
        color: AppColors.textPrimary,
      ),

      titleLarge: AppTextStyles.title.copyWith(color: AppColors.textPrimary),

      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),

      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textSecondary,
      ),

      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),

      labelLarge: AppTextStyles.button.copyWith(color: AppColors.whiteColor),
    ),
    brightness: Brightness.light,

    primaryColor: AppColors.primary,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      surface: AppColors.sruface,
      onPrimary: AppColors.whiteColor,
      onSurface: AppColors.textPrimary,
    ),

    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.sruface,
    dividerColor: AppColors.borderColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      indicatorColor: AppColors.primary.withOpacity(0.12),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: states.contains(WidgetState.selected)
              ? AppColors.primary
              : AppColors.textSecondary,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.primary
              : AppColors.textSecondary,
        );
      }),
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.whiteColor,
      iconColor: AppColors.textPrimary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    dialogTheme: const DialogThemeData(backgroundColor: AppColors.whiteColor),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.whiteColor,
      showDragHandle: true,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(),
      focusedBorder: UnderlineInputBorder(),
      labelStyle: TextStyle(color: AppColors.textPrimary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.whiteColor,
      selectedColor: AppColors.primary,
      showCheckmark: false,
      side: const BorderSide(color: AppColors.primary),
      labelStyle: const TextStyle(fontSize: 12, color: AppColors.blackColor),
      secondaryLabelStyle: const TextStyle(
        fontSize: 12,
        color: AppColors.whiteColor,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1.copyWith(
        color: AppColors.whiteColor,
      ),

      headlineMedium: AppTextStyles.heading2.copyWith(
        color: AppColors.whiteColor,
      ),

      headlineSmall: AppTextStyles.heading3.copyWith(
        color: AppColors.whiteColor,
      ),

      titleLarge: AppTextStyles.title.copyWith(color: AppColors.whiteColor),

      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.whiteColor),

      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.darkNeutral,
      ),

      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.darkNeutral),

      labelLarge: AppTextStyles.button.copyWith(color: AppColors.whiteColor),
    ),
    primaryColor: AppColors.darkPrimary,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      tertiary: AppColors.darkTertiary,
      surface: AppColors.darkBackground,
    ),

    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: const Color(0xFF1C1C1E),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1C1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF1C1C1E),
      indicatorColor: AppColors.darkPrimary.withOpacity(0.2),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: states.contains(WidgetState.selected)
              ? AppColors.darkPrimary
              : AppColors.darkNeutral,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.darkPrimary
              : AppColors.darkNeutral,
        );
      }),
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xFF1C1C1E),
      iconColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    dialogTheme: const DialogThemeData(backgroundColor: Color(0xFF393E46)),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF393E46),
      showDragHandle: true,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkPrimary),
      ),
      labelStyle: TextStyle(color: Colors.white70),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: AppColors.darkPrimary,
      showCheckmark: false,
      side: const BorderSide(color: AppColors.darkPrimary),
      labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
      secondaryLabelStyle: const TextStyle(fontSize: 12, color: Colors.white),
    ),
  );

  // static ThemeData lightTheme = ThemeData(
  //   useMaterial3: true,
  //   fontFamily: 'Inter',
  //   brightness: Brightness.light,
  //   primaryColor: const Color(0xFF08B3E5),
  //   colorScheme: ColorScheme.light(
  //     primary: const Color(0xFF08B3E5),
  //     secondary: const Color(0xFF2BB673),
  //   ),
  //   popupMenuTheme: PopupMenuThemeData(
  //     color: const Color(0xFFF8F9FA),
  //     iconColor: Colors.black,
  //     elevation: 2.0,
  //     shape: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(5.0),
  //       borderSide: BorderSide.none,
  //     ),
  //     menuPadding: EdgeInsets.all(8.0),
  //   ),
  //   scaffoldBackgroundColor: const Color(0xFFF8F9FA),
  //   cardColor: Colors.white,
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: Colors.white,
  //     foregroundColor: Colors.black,
  //     elevation: 0,
  //   ),
  //   inputDecorationTheme: const InputDecorationTheme(
  //     border: UnderlineInputBorder(),
  //     focusedBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(color: Color(0xFF08B3E5)),
  //     ),
  //     labelStyle: TextStyle(color: Colors.black),
  //   ),
  //   textButtonTheme: TextButtonThemeData(
  //     style: TextButton.styleFrom(foregroundColor: Color(0xFF08B3E5)),
  //   ),
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       foregroundColor: Colors.white,
  //       padding: const EdgeInsets.symmetric(vertical: 16),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //       backgroundColor: const Color(0xFF08B3E5),
  //     ),
  //   ),
  //   dialogTheme: DialogThemeData(backgroundColor: Colors.white),
  //   chipTheme: ChipThemeData(
  //     backgroundColor: Colors.white, //const Color(0xFF08B3E5),
  //     showCheckmark: false,
  //     selectedColor: const Color(0xFF08B3E5),
  //     labelStyle: TextStyle(fontSize: 12, color: Colors.black),
  //     secondaryLabelStyle: TextStyle(fontSize: 12, color: Colors.white),
  //     side: BorderSide(color: const Color(0xFF08B3E5)),
  //   ),

  //   // checkboxTheme: CheckboxThemeData(
  //   //   fillColor: WidgetStateProperty.all(const Color(0xFF08B3E5)),
  //   // ),
  // );

  // static ThemeData darkTheme = ThemeData(
  //   useMaterial3: true,
  //   fontFamily: 'Inter',
  //   brightness: Brightness.dark,
  //   popupMenuTheme: PopupMenuThemeData(
  //     color: const Color(0xFF1C1C1E),
  //     iconColor: Colors.white,
  //     elevation: 2.0,
  //     shape: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(5.0),
  //       borderSide: BorderSide.none,
  //     ),
  //     menuPadding: EdgeInsets.all(8.0),
  //   ),
  //   primaryColor: const Color(0xFF08B3E5),
  //   colorScheme: ColorScheme.dark(
  //     primary: const Color(0xFF08B3E5),
  //     secondary: const Color(0xFF2BB673),
  //   ),
  //   scaffoldBackgroundColor: Color(0xFF222831), // const Color(0xFF1C1C1E),
  //   cardColor: Color(0xFF393E46), //const Color(0xFF2C2C2E),
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: Color(0xFF1C1C1E),
  //     foregroundColor: Colors.white,
  //     elevation: 2,
  //   ),
  //   inputDecorationTheme: const InputDecorationTheme(
  //     border: UnderlineInputBorder(),
  //     focusedBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(color: Color(0xFF08B3E5)),
  //     ),
  //     labelStyle: TextStyle(color: Colors.white70),
  //   ),
  //   textButtonTheme: TextButtonThemeData(
  //     style: TextButton.styleFrom(foregroundColor: Color(0xFF08B3E5)),
  //   ),
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       foregroundColor: Colors.white,
  //       padding: const EdgeInsets.symmetric(vertical: 16),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //       backgroundColor: const Color(0xFF08B3E5),
  //     ),
  //   ),
  //   chipTheme: ChipThemeData(
  //     backgroundColor: Colors.white, //const Color(0xFF08B3E5),
  //     showCheckmark: false,
  //     selectedColor: const Color(0xFF08B3E5),
  //     labelStyle: TextStyle(fontSize: 12, color: Colors.black),
  //     secondaryLabelStyle: TextStyle(fontSize: 12, color: Colors.white),
  //     side: BorderSide(color: const Color(0xFF08B3E5)),
  //   ),
  //   dialogTheme: DialogThemeData(backgroundColor: Color(0xFF393E46)),
  // );
}

import 'package:flutter/material.dart';

ThemeData orangeTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFBF360C), // Dark Orange
  scaffoldBackgroundColor: const Color(0xFFFFFFFF), // White background
  cardColor: const Color(0xFFFFCCBC), // Light Orange for cards
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFBF360C)), // Dark Orange for text
    bodyMedium:
        TextStyle(color: Color(0xFFD84315)), // Medium Orange for subtler text
  ),
  iconTheme:
      const IconThemeData(color: Color(0xFFFF5722)), // Vibrant Orange for icons
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFFBF360C), // Dark Orange
    unselectedLabelColor: Color(0xFFD84315), // Medium Orange
    indicator: UnderlineTabIndicator(
      borderSide:
          BorderSide(color: Color(0xFFFF5722), width: 2.0), // Vibrant Orange
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFF5722), // Vibrant Orange
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF), // White for button text
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor:
        const Color(0xFFFFCCBC).withOpacity(0.5), // Light Orange with opacity
    hintStyle: const TextStyle(color: Color(0xFFFF5722)), // Vibrant Orange
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFFF5722)), // Vibrant Orange
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFD84315)), // Medium Orange
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFFFCCBC), // Light Orange
    iconTheme: IconThemeData(color: Color(0xFFBF360C)), // Dark Orange for icons
    titleTextStyle: TextStyle(
      color: Color(0xFFBF360C), // Dark Orange
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFFFF5722), // Vibrant Orange
    elevation: 5.0,
    shape: CircularNotchedRectangle(), // Supports a FloatingActionButton
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFFFFFFFF), // White for the dialog background
    titleTextStyle: const TextStyle(
      color: Color(0xFFBF360C), // Dark Orange for dialog titles
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: const TextStyle(
      color: Color(0xFFD84315), // Medium Orange for dialog content
      fontSize: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded corners for the dialog
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFF5722), // Vibrant Orange for FAB background
    foregroundColor: Color(0xFFFFFFFF), // White for FAB icon/text
    elevation: 6.0, // Default elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)), // Rounded corners
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
    primary: const Color(0xFFBF360C), // Dark Orange
    secondary: const Color(0xFFFF5722), // Vibrant Orange
    surface: const Color(0xFFFFCCBC), // Light Orange
    background: const Color(0xFFFFFFFF), // White background
    error: const Color(0xFFD32F2F), // Red for errors
    onPrimary: const Color(0xFFFFFFFF), // White for text on primary
    onSecondary: const Color(0xFFBF360C), // Dark Orange
    onSurface: const Color(0xFFD84315), // Medium Orange
    onBackground: const Color(0xFFBF360C), // Dark Orange
    onError: const Color(0xFFFFFFFF), // White for text on error
  ),
);

ThemeData greenTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF1B5E20), // Forest Green
  scaffoldBackgroundColor: const Color(0xFFFFFFFF), // White background
  cardColor: const Color(0xFFA5D6A7), // Light Green for cards
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF1B5E20)), // Forest Green for text
    bodyMedium:
        TextStyle(color: Color(0xFF388E3C)), // Medium Green for subtler text
  ),
  iconTheme:
      const IconThemeData(color: Color(0xFF66BB6A)), // Vibrant Green for icons
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFF1B5E20), // Forest Green
    unselectedLabelColor: Color(0xFF388E3C), // Medium Green
    indicator: UnderlineTabIndicator(
      borderSide:
          BorderSide(color: Color(0xFF66BB6A), width: 2.0), // Vibrant Green
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFF66BB6A), // Vibrant Green
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF), // White for button text
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor:
        const Color(0xFFA5D6A7).withOpacity(0.5), // Light Green with opacity
    hintStyle: const TextStyle(color: Color(0xFF66BB6A)), // Vibrant Green
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF66BB6A)), // Vibrant Green
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF388E3C)), // Medium Green
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFA5D6A7), // Light Green
    iconTheme:
        IconThemeData(color: Color(0xFF1B5E20)), // Forest Green for icons
    titleTextStyle: TextStyle(
      color: Color(0xFF1B5E20), // Forest Green
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFF66BB6A), // Vibrant Green
    elevation: 5.0,
    shape: CircularNotchedRectangle(), // Supports a FloatingActionButton
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFFFFFFFF), // White for the dialog background
    titleTextStyle: const TextStyle(
      color: Color(0xFF1B5E20), // Forest Green for dialog titles
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: const TextStyle(
      color: Color(0xFF388E3C), // Medium Green for dialog content
      fontSize: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded corners for the dialog
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF66BB6A), // Vibrant Green for FAB background
    foregroundColor: Color(0xFFFFFFFF), // White for FAB icon/text
    elevation: 6.0, // Default elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)), // Rounded corners
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
    primary: const Color(0xFF1B5E20), // Forest Green
    secondary: const Color(0xFF66BB6A), // Vibrant Green
    surface: const Color(0xFFA5D6A7), // Light Green
    background: const Color(0xFFFFFFFF), // White background
    error: const Color(0xFFD32F2F), // Red for errors
    onPrimary: const Color(0xFFFFFFFF), // White for text on primary
    onSecondary: const Color(0xFF1B5E20), // Forest Green
    onSurface: const Color(0xFF388E3C), // Medium Green
    onBackground: const Color(0xFF1B5E20), // Forest Green
    onError: const Color(0xFFFFFFFF), // White for text on error
  ),
);

ThemeData darkAshTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF212121), // Dark Ash
  scaffoldBackgroundColor: const Color(0xFF121212), // Darker Ash background
  cardColor: const Color(0xFF424242), // Light Ash for cards
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // White for large text
    bodyMedium:
        TextStyle(color: Color(0xFFBDBDBD)), // Light Grey for subtler text
  ),
  iconTheme:
      const IconThemeData(color: Color(0xFF757575)), // Medium Ash for icons
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFFFFFFFF), // White
    unselectedLabelColor: Color(0xFFBDBDBD), // Light Grey
    indicator: UnderlineTabIndicator(
      borderSide:
          BorderSide(color: Color(0xFF757575), width: 2.0), // Medium Ash
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFF424242), // Light Ash
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF), // White for button text
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor:
        const Color(0xFF424242).withOpacity(0.5), // Light Ash with opacity
    hintStyle: const TextStyle(color: Color(0xFF757575)), // Medium Ash
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF757575)), // Medium Ash
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFFFFFFF)), // White
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF212121), // Dark Ash
    iconTheme: IconThemeData(color: Color(0xFFFFFFFF)), // White for icons
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFFFF), // White
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFF424242), // Light Ash
    elevation: 5.0,
    shape: CircularNotchedRectangle(), // Supports a FloatingActionButton
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFF212121), // Dark Ash for dialog background
    titleTextStyle: const TextStyle(
      color: Color(0xFFFFFFFF), // White for dialog titles
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: const TextStyle(
      color: Color(0xFFBDBDBD), // Light Grey for dialog content
      fontSize: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded corners for the dialog
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF757575), // Medium Ash for FAB background
    foregroundColor: Color(0xFFFFFFFF), // White for FAB icon/text
    elevation: 6.0, // Default elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)), // Rounded corners
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
    primary: const Color(0xFF212121), // Dark Ash
    secondary: const Color.fromARGB(255, 91, 91, 91), // Light Ash
    surface: const Color(0xFF424242), // Light Ash
    background: const Color(0xFF121212), // Darker Ash background
    error: const Color(0xFFD32F2F), // Red for errors
    onPrimary: const Color(0xFFFFFFFF), // White for text on primary
    onSecondary: const Color(0xFFBDBDBD), // Light Grey
    onSurface: const Color(0xFFBDBDBD), // Light Grey
    onBackground: const Color(0xFFFFFFFF), // White
    onError: const Color(0xFFFFFFFF), // White for text on error
  ),
);

ThemeData purpleTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF6A1B9A), // Deep Purple
  scaffoldBackgroundColor: const Color(0xFFF3E5F5), // Light Lavender background
  cardColor: const Color(0xFFE1BEE7), // Soft Purple for cards
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF4A148C)), // Dark Purple for text
    bodyMedium:
        TextStyle(color: Color(0xFF8E24AA)), // Medium Purple for subtler text
  ),
  iconTheme:
      const IconThemeData(color: Color(0xFFAB47BC)), // Vibrant Purple for icons
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFF4A148C), // Dark Purple
    unselectedLabelColor: Color(0xFF8E24AA), // Medium Purple
    indicator: UnderlineTabIndicator(
      borderSide:
          BorderSide(color: Color(0xFFAB47BC), width: 2.0), // Vibrant Purple
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFAB47BC), // Vibrant Purple
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF), // White for button text
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor:
        const Color(0xFFE1BEE7).withOpacity(0.5), // Soft Purple with opacity
    hintStyle: const TextStyle(color: Color(0xFFAB47BC)), // Vibrant Purple
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFAB47BC)), // Vibrant Purple
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF8E24AA)), // Medium Purple
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF6A1B9A), // Deep Purple
    iconTheme: IconThemeData(color: Color(0xFFFFFFFF)), // White for icons
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFFFF), // White
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFFAB47BC), // Vibrant Purple
    elevation: 5.0,
    shape: CircularNotchedRectangle(), // Supports a FloatingActionButton
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFFFFFFFF), // White for dialog background
    titleTextStyle: const TextStyle(
      color: Color(0xFF4A148C), // Dark Purple for dialog titles
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: const TextStyle(
      color: Color(0xFF8E24AA), // Medium Purple for dialog content
      fontSize: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded corners for the dialog
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFAB47BC), // Vibrant Purple for FAB background
    foregroundColor: Color(0xFFFFFFFF), // White for FAB icon/text
    elevation: 6.0, // Default elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)), // Rounded corners
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
    primary: const Color(0xFF6A1B9A), // Deep Purple
    secondary: const Color(0xFFAB47BC), // Vibrant Purple
    surface: const Color(0xFFE1BEE7), // Soft Purple
    background: const Color(0xFFF3E5F5), // Light Lavender background
    error: const Color(0xFFD32F2F), // Red for errors
    onPrimary: const Color(0xFFFFFFFF), // White for text on primary
    onSecondary: const Color(0xFF4A148C), // Dark Purple
    onSurface: const Color(0xFF8E24AA), // Medium Purple
    onBackground: const Color(0xFF4A148C), // Dark Purple
    onError: const Color(0xFFFFFFFF), // White for text on error
  ),
);

ThemeData yellowTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFFBC02D), // Bright Yellow
  scaffoldBackgroundColor: const Color(0xFFFFFDE7), // Pale Yellow background
  cardColor: const Color(0xFFFFF9C4), // Light Yellow for cards
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFF57F17)), // Deep Yellow for text
    bodyMedium:
        TextStyle(color: Color(0xFFFBC02D)), // Bright Yellow for subtler text
  ),
  iconTheme:
      const IconThemeData(color: Color(0xFFFFEB3B)), // Vibrant Yellow for icons
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFFF57F17), // Deep Yellow
    unselectedLabelColor: Color(0xFFFBC02D), // Bright Yellow
    indicator: UnderlineTabIndicator(
      borderSide:
          BorderSide(color: Color(0xFFFFEB3B), width: 2.0), // Vibrant Yellow
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFEB3B), // Vibrant Yellow
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFF000000), // Black for button text
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor:
        const Color(0xFFFFF9C4).withOpacity(0.5), // Light Yellow with opacity
    hintStyle: const TextStyle(color: Color(0xFFFFEB3B)), // Vibrant Yellow
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFFFEB3B)), // Vibrant Yellow
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFFBC02D)), // Bright Yellow
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFFBC02D), // Bright Yellow
    iconTheme: IconThemeData(color: Color(0xFF000000)), // Black for icons
    titleTextStyle: TextStyle(
      color: Color(0xFF000000), // Black
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFFFFEB3B), // Vibrant Yellow
    elevation: 5.0,
    shape: CircularNotchedRectangle(), // Supports a FloatingActionButton
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFFFFFFFF), // White for dialog background
    titleTextStyle: const TextStyle(
      color: Color(0xFFF57F17), // Deep Yellow for dialog titles
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: const TextStyle(
      color: Color(0xFFFBC02D), // Bright Yellow for dialog content
      fontSize: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded corners for the dialog
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFFEB3B), // Vibrant Yellow for FAB background
    foregroundColor: Color(0xFF000000), // Black for FAB icon/text
    elevation: 6.0, // Default elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)), // Rounded corners
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
    primary: const Color(0xFFFBC02D), // Bright Yellow
    secondary: const Color(0xFFFFEB3B), // Vibrant Yellow
    surface: const Color(0xFFFFF9C4), // Light Yellow
    background: const Color(0xFFFFFDE7), // Pale Yellow background
    error: const Color(0xFFD32F2F), // Red for errors
    onPrimary: const Color(0xFF000000), // Black for text on primary
    onSecondary: const Color(0xFF000000), // Black for text on secondary
    onSurface: const Color(0xFFF57F17), // Deep Yellow
    onBackground: const Color(0xFFF57F17), // Deep Yellow
    onError: const Color(0xFFFFFFFF), // White for text on error
  ),
);

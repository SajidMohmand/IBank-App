import 'package:flutter/material.dart';
import 'package:i_bank/presentation/navigation/routes.dart';
import 'package:i_bank/presentation/screens/authentication/change_password_screen.dart';
import 'package:i_bank/presentation/screens/authentication/forgot_password_screen.dart';
import 'package:i_bank/presentation/screens/authentication/login_screen.dart';
import 'package:i_bank/presentation/screens/authentication/password_changed_success_screen.dart';
import 'package:i_bank/presentation/screens/authentication/signup_screen.dart';
import 'package:i_bank/presentation/screens/tab_screen.dart';
import 'package:i_bank/presentation/screens/tabs/home_screen.dart';
import 'package:i_bank/presentation/screens/tabs/message_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search/Exchange/confirm_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search/Exchange/transfer_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search/exchange_rate_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search/exchange_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search/interest_rate_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search/search_branch_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search_screen.dart';
import 'package:i_bank/presentation/screens/tabs/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: Color(0xff3629b7),
        useMaterial3: true,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Source_Sans_3',
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Source_Sans_3',
          ),
        ),
      ),
      routes: {
        '/': (context)=> TabScreen(),
        Routes.tabScreen: (context)=> TabScreen(),
        Routes.login: (context) => LoginScreen(),
        Routes.signup: (context) => SignupScreen(),
        Routes.forgotPassword: (context) => ForgotPasswordScreen(),
        Routes.changePassword: (context) => ChangePasswordScreen(),
        Routes.successChangePassword: (context) => PasswordChangedSuccessScreen(),
        Routes.searchBranchScreen: (context) => SearchBranchScreen(),
        Routes.interestRateScreen: (context) => InterestRateScreen(),
        Routes.exchangeRateScreen: (context) => ExchangeRateScreen(),
        Routes.exchangeScreen: (context) => ExchangeScreen(),
        Routes.transferScreen: (context) => TransferScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == Routes.confirmScreen) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ConfirmScreen(
              from: args['from'],
              name: args['name'],
              cardNumber: args['cardNumber'],
              amount: args['amount'],
              content: args['content'],
            ),
          );
        }
        return null;
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:couldai_user_app/theme/app_theme.dart';
import 'package:couldai_user_app/screens/campaign_screen.dart';

void main() {
  runApp(const Super6App());
}

class Super6App extends StatelessWidget {
  const Super6App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super 6',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const CampaignScreen(),
    );
  }
}

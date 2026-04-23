import 'package:flutter/material.dart';
import 'package:couldai_user_app/widgets/countdown_timer.dart';
import 'package:couldai_user_app/screens/match_selection_screen.dart';
import 'package:couldai_user_app/theme/app_theme.dart';

class CampaignScreen extends StatelessWidget {
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              const Center(child: CountdownTimerWidget()),
              const SizedBox(height: 32),
              _buildPrizeSection(context),
              const SizedBox(height: 48),
              _buildCTA(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.backgroundColor,
            AppTheme.cardColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'SUPER 6',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.primaryColor,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      color: AppTheme.primaryColor.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'Predict 6 correct scores to win big!',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prize Pool',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildPrizeCard(context, '6 Correct', 'R\$ 1,000,000', isHighlight: true),
          const SizedBox(height: 12),
          _buildPrizeCard(context, '5 Correct', 'R\$ 50,000'),
          const SizedBox(height: 12),
          _buildPrizeCard(context, '4 Correct', 'R\$ 20,000'),
          const SizedBox(height: 12),
          _buildPrizeCard(context, '3 Correct', 'R\$ 25 Free Bet'),
          const SizedBox(height: 12),
          _buildPrizeCard(context, '2 Correct', 'R\$ 10 Free Bet'),
        ],
      ),
    );
  }

  Widget _buildPrizeCard(BuildContext context, String title, String prize, {bool isHighlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isHighlight
            ? Border.all(color: AppTheme.primaryColor, width: 2)
            : Border.all(color: Colors.transparent),
        boxShadow: isHighlight
            ? [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isHighlight ? AppTheme.primaryColor : Colors.white,
                ),
          ),
          Text(
            prize,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isHighlight ? AppTheme.primaryColor : Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTA(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MatchSelectionScreen()),
          );
        },
        child: const Text('ENTER NOW'),
      ),
    );
  }
}

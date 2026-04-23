import 'package:flutter/material.dart';
import 'package:couldai_user_app/theme/app_theme.dart';
import 'package:couldai_user_app/screens/campaign_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 64,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Predictions Submitted!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Good luck! Your Super 6 picks have been recorded. You will be notified of the results after the final match.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(height: 48),
              _buildShareCard(context),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const CampaignScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareCard(BuildContext context) {
    return Card(
      color: AppTheme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Challenge your friends',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Share your picks and see who gets the highest score.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Share functionality placeholder
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Share functionality coming soon!')),
                );
              },
              icon: const Icon(Icons.share, color: AppTheme.primaryColor),
              label: const Text(
                'Share Picks',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primaryColor),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

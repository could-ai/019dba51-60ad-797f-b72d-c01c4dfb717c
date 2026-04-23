import 'package:flutter/material.dart';
import 'package:couldai_user_app/theme/app_theme.dart';
import 'package:couldai_user_app/screens/match_selection_screen.dart';
import 'package:couldai_user_app/screens/success_screen.dart';

class SummaryScreen extends StatelessWidget {
  final List<Match> matches;

  const SummaryScreen({Key? key, required this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isComplete = matches.every((m) => m.selectedScore != null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Predictions'),
      ),
      body: Column(
        children: [
          _buildSummaryHeader(context, isComplete),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return _buildSummaryCard(context, matches[index], index + 1);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: isComplete
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SuccessScreen()),
                  (route) => false,
                );
              },
              label: const Text('Submit Predictions', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              icon: const Icon(Icons.send, color: Colors.black),
              backgroundColor: AppTheme.primaryColor,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSummaryHeader(BuildContext context, bool isComplete) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppTheme.cardColor,
      child: Row(
        children: [
          Icon(
            isComplete ? Icons.check_circle : Icons.warning_amber_rounded,
            color: isComplete ? AppTheme.primaryColor : Colors.orange,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isComplete ? 'All set!' : 'Incomplete Predictions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  isComplete
                      ? 'Review your picks and submit below.'
                      : 'Please complete all match predictions to submit.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, Match match, int matchNumber) {
    bool hasPrediction = match.selectedScore != null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: hasPrediction ? Colors.transparent : Colors.red.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: hasPrediction ? AppTheme.primaryColor.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '\$matchNumber',
                  style: TextStyle(
                    color: hasPrediction ? AppTheme.primaryColor : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\${match.homeTeam} vs \${match.awayTeam}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    match.dateTime,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: hasPrediction ? AppTheme.primaryColor : AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: hasPrediction ? AppTheme.primaryColor : Colors.grey.shade700,
                ),
              ),
              child: Text(
                hasPrediction ? match.selectedScore! : '?',
                style: TextStyle(
                  color: hasPrediction ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

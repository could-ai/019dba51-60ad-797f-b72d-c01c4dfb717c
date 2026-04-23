import 'package:flutter/material.dart';
import 'package:couldai_user_app/theme/app_theme.dart';
import 'package:couldai_user_app/screens/success_screen.dart';

class SummaryScreen extends StatelessWidget {
  final Map<String, String> predictions;

  const SummaryScreen({Key? key, required this.predictions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if we have 6 predictions
    bool isComplete = predictions.length == 6;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisar Palpites'),
      ),
      body: Column(
        children: [
          _buildHeader(context, isComplete),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 6, // Mocking the 6 matches again for the summary
              itemBuilder: (context, index) {
                String matchId = (index + 1).toString();
                String score = predictions[matchId] ?? '--';
                return _buildSummaryCard(context, matchId, score);
              },
            ),
          ),
          _buildFooter(context, isComplete),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isComplete) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppTheme.cardColor,
      width: double.infinity,
      child: Column(
        children: [
          Icon(
            isComplete ? Icons.check_circle_outline : Icons.info_outline,
            color: isComplete ? AppTheme.primaryColor : Colors.orange,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            isComplete ? 'Tudo pronto!' : 'Palpites Incompletos',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: isComplete ? AppTheme.primaryColor : Colors.white,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            isComplete
                ? 'Revise seus palpites e envie abaixo.'
                : 'Por favor, complete todos os palpites para enviar.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String matchId, String score) {
    // Quick mock of match teams corresponding to IDs
    final Map<String, List<String>> mockTeams = {
      '1': ['Brasil', 'Argentina'],
      '2': ['Flamengo', 'Palmeiras'],
      '3': ['Real Madrid', 'Barcelona'],
      '4': ['Man City', 'Arsenal'],
      '5': ['Bayern', 'Dortmund'],
      '6': ['Boca Juniors', 'River Plate'],
    };

    final teams = mockTeams[matchId] ?? ['Time A', 'Time B'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              teams[0],
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              score,
              style: TextStyle(
                color: score == '--' ? Colors.grey : AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Text(
              teams[1],
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isComplete) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isComplete
              ? () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const SuccessScreen(),
                    ),
                    (route) => false,
                  );
                }
              : null,
          child: const Text('ENVIAR PALPITES'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:couldai_user_app/theme/app_theme.dart';
import 'package:couldai_user_app/screens/detailed_prediction_screen.dart';
import 'package:couldai_user_app/screens/summary_screen.dart';

class Match {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String dateTime;

  Match({required this.id, required this.homeTeam, required this.awayTeam, required this.dateTime});
}

class MatchSelectionScreen extends StatefulWidget {
  const MatchSelectionScreen({Key? key}) : super(key: key);

  @override
  State<MatchSelectionScreen> createState() => _MatchSelectionScreenState();
}

class _MatchSelectionScreenState extends State<MatchSelectionScreen> {
  // Mock matches for the prototype
  final List<Match> matches = [
    Match(id: '1', homeTeam: 'Brasil', awayTeam: 'Argentina', dateTime: '25 Out, 20:00'),
    Match(id: '2', homeTeam: 'Flamengo', awayTeam: 'Palmeiras', dateTime: '26 Out, 16:00'),
    Match(id: '3', homeTeam: 'Real Madrid', awayTeam: 'Barcelona', dateTime: '26 Out, 21:00'),
    Match(id: '4', homeTeam: 'Man City', awayTeam: 'Arsenal', dateTime: '27 Out, 14:00'),
    Match(id: '5', homeTeam: 'Bayern', awayTeam: 'Dortmund', dateTime: '27 Out, 18:30'),
    Match(id: '6', homeTeam: 'Boca Juniors', awayTeam: 'River Plate', dateTime: '28 Out, 19:00'),
  ];

  // Store selected scores: matchId -> score string (e.g., '2-1')
  final Map<String, String> predictions = {};

  // Common quick scores to display
  final List<String> quickScores = ['1-0', '2-0', '2-1', '0-0', '1-1', '0-1', '0-2', '1-2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palpites Super 6'),
      ),
      body: Column(
        children: [
          _buildProgressHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return _buildMatchCard(matches[index], index + 1);
              },
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    int predictedCount = predictions.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: AppTheme.cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Seus Palpites',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '$predictedCount / 6',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: predictedCount == 6 ? AppTheme.primaryColor : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(Match match, int matchNumber) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jogo $matchNumber',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.primaryColor,
                    ),
              ),
              Text(
                match.dateTime,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  match.homeTeam,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'vs',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondaryColor),
                ),
              ),
              Expanded(
                child: Text(
                  match.awayTeam,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildScoreGrid(match),
        ],
      ),
    );
  }

  Widget _buildScoreGrid(Match match) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        ...quickScores.map((score) => _buildScoreOption(match.id, score)),
        _buildOtherOption(match),
      ],
    );
  }

  Widget _buildScoreOption(String matchId, String score) {
    bool isSelected = predictions[matchId] == score;
    return GestureDetector(
      onTap: () {
        setState(() {
          predictions[matchId] = score;
        });
      },
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondaryColor.withOpacity(0.3),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          score,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOtherOption(Match match) {
    // If the prediction is not in the quick scores, show it here as selected.
    bool hasCustomScore = predictions[match.id] != null && !quickScores.contains(predictions[match.id]);
    
    return GestureDetector(
      onTap: () async {
        // Navigate to detailed screen
        final result = await Navigator.of(context).push<String>(
          MaterialPageRoute(
            builder: (context) => DetailedPredictionScreen(
              matchHome: match.homeTeam,
              matchAway: match.awayTeam,
              initialScore: predictions[match.id],
            ),
          ),
        );

        if (result != null) {
          setState(() {
            predictions[match.id] = result;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        decoration: BoxDecoration(
          color: hasCustomScore ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hasCustomScore ? AppTheme.primaryColor : AppTheme.textSecondaryColor.withOpacity(0.3),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          hasCustomScore ? predictions[match.id]! : 'Outro',
          style: TextStyle(
            color: hasCustomScore ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
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
      child: ElevatedButton(
        onPressed: predictions.length == 6
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SummaryScreen(predictions: predictions),
                  ),
                );
              }
            : null,
        child: const Text('REVISAR PALPITES'),
      ),
    );
  }
}

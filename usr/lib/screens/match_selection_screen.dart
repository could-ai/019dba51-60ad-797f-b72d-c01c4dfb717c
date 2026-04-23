import 'package:flutter/material.dart';
import 'package:couldai_user_app/theme/app_theme.dart';
import 'package:couldai_user_app/screens/detailed_prediction_screen.dart';
import 'package:couldai_user_app/screens/summary_screen.dart';

class Match {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String dateTime;
  String? selectedScore;

  Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.dateTime,
    this.selectedScore,
  });
}

class MatchSelectionScreen extends StatefulWidget {
  const MatchSelectionScreen({Key? key}) : super(key: key);

  @override
  State<MatchSelectionScreen> createState() => _MatchSelectionScreenState();
}

class _MatchSelectionScreenState extends State<MatchSelectionScreen> {
  final List<Match> matches = [
    Match(id: '1', homeTeam: 'Brazil', awayTeam: 'Argentina', dateTime: 'Oct 25, 20:00'),
    Match(id: '2', homeTeam: 'Flamengo', awayTeam: 'Palmeiras', dateTime: 'Oct 26, 16:00'),
    Match(id: '3', homeTeam: 'Real Madrid', awayTeam: 'Barcelona', dateTime: 'Oct 26, 21:00'),
    Match(id: '4', homeTeam: 'Man City', awayTeam: 'Arsenal', dateTime: 'Oct 27, 14:00'),
    Match(id: '5', homeTeam: 'Bayern', awayTeam: 'Dortmund', dateTime: 'Oct 27, 18:30'),
    Match(id: '6', homeTeam: 'Boca Juniors', awayTeam: 'River Plate', dateTime: 'Oct 28, 19:00'),
  ];

  final List<String> commonScores = ['0-0', '1-0', '0-1', '1-1', '2-1', '1-2'];

  @override
  Widget build(BuildContext context) {
    int completedPicks = matches.where((m) => m.selectedScore != null).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Super 6 Predictions'),
      ),
      body: Column(
        children: [
          _buildProgressHeader(completedPicks),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 100), // Space for floating button
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return _buildMatchCard(matches[index], index + 1);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: completedPicks == 6
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SummaryScreen(matches: matches)),
                );
              },
              label: const Text('Review Predictions', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              icon: const Icon(Icons.check, color: Colors.black),
              backgroundColor: AppTheme.primaryColor,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildProgressHeader(int completedPicks) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: AppTheme.cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Your Picks',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: completedPicks == 6 ? AppTheme.primaryColor : Colors.transparent,
              border: Border.all(color: AppTheme.primaryColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '\$completedPicks / 6',
              style: TextStyle(
                color: completedPicks == 6 ? Colors.black : AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(Match match, int matchNumber) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Match \$matchNumber',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.primaryColor),
                ),
                Text(
                  match.dateTime,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    match.homeTeam,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('vs', style: TextStyle(color: Colors.grey)),
                ),
                Expanded(
                  child: Text(
                    match.awayTeam,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                ...commonScores.map((score) => _buildScoreButton(match, score)),
                _buildOtherButton(match),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreButton(Match match, String score) {
    bool isSelected = match.selectedScore == score;
    return GestureDetector(
      onTap: () {
        setState(() {
          match.selectedScore = score;
        });
      },
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade800,
          ),
        ),
        child: Center(
          child: Text(
            score,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtherButton(Match match) {
    bool isOtherSelected = match.selectedScore != null && !commonScores.contains(match.selectedScore);
    
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailedPredictionScreen(match: match),
          ),
        );
        if (result != null) {
          setState(() {
            match.selectedScore = result;
          });
        }
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isOtherSelected ? AppTheme.primaryColor : AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isOtherSelected ? AppTheme.primaryColor : Colors.grey.shade800,
          ),
        ),
        child: Center(
          child: Text(
            isOtherSelected ? match.selectedScore! : 'Other',
            style: TextStyle(
              color: isOtherSelected ? Colors.black : Colors.white,
              fontWeight: isOtherSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

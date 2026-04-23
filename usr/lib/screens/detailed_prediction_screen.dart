import 'package:flutter/material.dart';
import 'package:couldai_user_app/theme/app_theme.dart';
import 'package:couldai_user_app/screens/match_selection_screen.dart';

class DetailedPredictionScreen extends StatefulWidget {
  final Match match;

  const DetailedPredictionScreen({Key? key, required this.match}) : super(key: key);

  @override
  State<DetailedPredictionScreen> createState() => _DetailedPredictionScreenState();
}

class _DetailedPredictionScreenState extends State<DetailedPredictionScreen> {
  String? selectedScore;
  String? selectedScorer;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedScore = widget.match.selectedScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detailed Prediction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMatchHeader(),
              const SizedBox(height: 32),
              Text('Exact Score', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              _buildScoreGrid(),
              const SizedBox(height: 32),
              Text('Extra Questions (Optional)', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              _buildDropdownQuestion(
                'First Goal Scorer',
                ['Any Player', 'No Goalscorer', 'Striker A', 'Striker B', 'Midfielder C'],
                selectedScorer,
                (val) => setState(() => selectedScorer = val),
              ),
              const SizedBox(height: 16),
              _buildDropdownQuestion(
                'Time of First Goal',
                ['0-15 min', '16-30 min', '31-45 min', '46-60 min', '61-75 min', '76-90 min', 'No Goal'],
                selectedTime,
                (val) => setState(() => selectedTime = val),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: selectedScore != null
                    ? () {
                        Navigator.of(context).pop(selectedScore);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedScore != null ? AppTheme.primaryColor : Colors.grey.shade800,
                ),
                child: Text(
                  'Confirm Selection',
                  style: TextStyle(
                    color: selectedScore != null ? Colors.black : Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                widget.match.homeTeam,
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
                widget.match.awayTeam,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreGrid() {
    List<String> allScores = [];
    for (int i = 0; i <= 4; i++) {
      for (int j = 0; j <= 4; j++) {
        allScores.add('\$i-\$j');
      }
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: allScores.length,
      itemBuilder: (context, index) {
        String score = allScores[index];
        bool isSelected = selectedScore == score;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedScore = score;
            });
          },
          child: Container(
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
      },
    );
  }

  Widget _buildDropdownQuestion(String label, List<String> options, String? currentValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade800),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: currentValue,
              hint: const Text('Select an option'),
              dropdownColor: AppTheme.cardColor,
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

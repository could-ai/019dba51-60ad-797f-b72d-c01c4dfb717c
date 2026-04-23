import 'package:flutter/material.dart';
import 'package:couldai_user_app/theme/app_theme.dart';

class DetailedPredictionScreen extends StatefulWidget {
  final String matchHome;
  final String matchAway;
  final String? initialScore;

  const DetailedPredictionScreen({
    Key? key,
    required this.matchHome,
    required this.matchAway,
    this.initialScore,
  }) : super(key: key);

  @override
  State<DetailedPredictionScreen> createState() => _DetailedPredictionScreenState();
}

class _DetailedPredictionScreenState extends State<DetailedPredictionScreen> {
  int homeScore = 0;
  int awayScore = 0;
  String? firstGoalScorer;
  String? firstGoalTime;

  @override
  void initState() {
    super.initState();
    if (widget.initialScore != null) {
      final parts = widget.initialScore!.split('-');
      if (parts.length == 2) {
        homeScore = int.tryParse(parts[0]) ?? 0;
        awayScore = int.tryParse(parts[1]) ?? 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palpite Detalhado'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildScoreSelector(),
            const SizedBox(height: 32),
            const Divider(color: AppTheme.cardColor, thickness: 2),
            const SizedBox(height: 24),
            Text(
              'Perguntas Extras (Opcional)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildFirstGoalScorer(),
            const SizedBox(height: 24),
            _buildFirstGoalTime(),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // Return exact score string
                Navigator.of(context).pop('\$homeScore-\$awayScore');
              },
              child: const Text('CONFIRMAR SELEÇÃO'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreSelector() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Placar Exato',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.primaryColor),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTeamScoreControl(widget.matchHome, homeScore, (newScore) {
                setState(() {
                  homeScore = newScore;
                });
              }),
              Text('X', style: Theme.of(context).textTheme.headlineMedium),
              _buildTeamScoreControl(widget.matchAway, awayScore, (newScore) {
                setState(() {
                  awayScore = newScore;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamScoreControl(String teamName, int score, Function(int) onChanged) {
    return Column(
      children: [
        Text(
          teamName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              color: Colors.white,
              onSize: 32,
              onPressed: score > 0 ? () => onChanged(score - 1) : null,
            ),
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.primaryColor),
              ),
              child: Text(
                score.toString(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: AppTheme.primaryColor,
              onPressed: () => onChanged(score + 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFirstGoalScorer() {
    final List<String> options = ['Qualquer Jogador', 'Sem Gols', 'Atacante A', 'Atacante B', 'Meio-campista C'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Primeiro Jogador a Marcar',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: AppTheme.cardColor,
              value: firstGoalScorer,
              hint: const Text('Selecione uma opção', style: TextStyle(color: AppTheme.textSecondaryColor)),
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  firstGoalScorer = newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFirstGoalTime() {
    final List<String> options = [
      '0-15 min',
      '16-30 min',
      '31-45 min',
      '46-60 min',
      '61-75 min',
      '76-90 min',
      'Sem Gols'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Momento do Primeiro Gol',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            bool isSelected = firstGoalTime == option;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              selectedColor: AppTheme.primaryColor,
              backgroundColor: AppTheme.cardColor,
              labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white),
              onSelected: (selected) {
                setState(() {
                  firstGoalTime = selected ? option : null;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

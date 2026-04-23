import 'package:flutter/material.dart';
import 'package:couldai_user_app/widgets/countdown_timer.dart';
import 'package:couldai_user_app/screens/match_selection_screen.dart';
import 'package:couldai_user_app/theme/app_theme.dart';

class CampaignScreen extends StatelessWidget {
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSportsBanner(context),
            const SizedBox(height: 32),
            _buildPrizeSection(context),
            const SizedBox(height: 48),
            _buildCTA(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSportsBanner(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1518605368461-1e1e11af2859?q=80&w=800&auto=format&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              AppTheme.backgroundColor.withOpacity(0.8),
              AppTheme.backgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'SUPER 6',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppTheme.primaryColor,
                    letterSpacing: 3.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 10,
                      ),
                    ],
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Acerte o placar e concorra a prêmios',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 4,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const CountdownTimerWidget(),
          ],
        ),
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
            'Premiação',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildPrizeCard(context, '6 Acertos', 'R\$ 1.000.000', isHighlight: true),
          const SizedBox(height: 12),
          _buildPrizeCard(context, '5 Acertos', 'R\$ 50.000'),
          const SizedBox(height: 12),
          _buildPrizeCard(context, '4 Acertos', 'R\$ 20.000'),
          const SizedBox(height: 12),
          _buildPrizeCard(context, '3 Acertos', 'Aposta Grátis R\$ 25'),
          const SizedBox(height: 12),
          _buildPrizeCard(context, '2 Acertos', 'Aposta Grátis R\$ 10'),
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
        child: const Text('PARTICIPAR AGORA'),
      ),
    );
  }
}

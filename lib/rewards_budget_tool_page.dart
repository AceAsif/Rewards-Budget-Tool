import 'package:flutter/material.dart';

class RewardsBudgetToolPage extends StatefulWidget {
  const RewardsBudgetToolPage({super.key, required this.title});
  final String title;

  @override
  State<RewardsBudgetToolPage> createState() => _RewardsBudgetToolPageState();
}

class _RewardsBudgetToolPageState extends State<RewardsBudgetToolPage> {
  final TextEditingController _budgetController = TextEditingController(text: '1500');
  final TextEditingController _usersController = TextEditingController(text: '10');
  final TextEditingController _rewardController = TextEditingController(text: '50');

  double? _maxRewardPerUser;
  int? _maxUsersCovered;
  double? _totalCostIfAllUsersSucceed;

  void _calculate() {
    final double budget = double.tryParse(_budgetController.text) ?? 0;
    final int users = int.tryParse(_usersController.text) ?? 0;
    final double reward = double.tryParse(_rewardController.text) ?? 0;

    setState(() {
      _maxRewardPerUser = users > 0 ? budget / users : 0;
      _maxUsersCovered = reward > 0 ? (budget ~/ reward) : 0;
      _totalCostIfAllUsersSucceed = users * reward;
    });
  }

  void _reset() {
    setState(() {
      _budgetController.text = '1500';
      _usersController.text = '10';
      _rewardController.text = '50';
      _maxRewardPerUser = null;
      _maxUsersCovered = null;
      _totalCostIfAllUsersSucceed = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enter Your Budget Settings:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildInputField(_budgetController, 'Total Budget (\$)'),
            _buildInputField(_usersController, 'Total Users'),
            _buildInputField(_rewardController, 'Reward Per User (\$)'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calculate,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calculate'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.deepPurple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_maxRewardPerUser != null) _buildResultSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildResultSection() {
    final budget = double.tryParse(_budgetController.text) ?? 0;
    final isWithinBudget = _totalCostIfAllUsersSucceed! <= budget;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('💡 Max Affordable Reward per User (within budget): \$${_maxRewardPerUser!.toStringAsFixed(2)}'),
        Text('🎯 Max Users You Can Fully Reward (within budget): $_maxUsersCovered'),
        Text('📅 Planned Total Cost (All Users Redeem): \$${_totalCostIfAllUsersSucceed!.toStringAsFixed(2)}'),
        const SizedBox(height: 12),
        Text(
          isWithinBudget
              ? '✅ Your plan is within the budget.'
              : '⚠️ Warning: Your current plan would exceed your budget.\nPlease reduce rewards, users, or increase your budget.',
          style: TextStyle(
            color: isWithinBudget ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

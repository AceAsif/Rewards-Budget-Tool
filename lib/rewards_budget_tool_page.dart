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
    _budgetController.text = '1500';
    _usersController.text = '10';
    _rewardController.text = '50';
    setState(() {
      _maxRewardPerUser = null;
      _maxUsersCovered = null;
      _totalCostIfAllUsersSucceed = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextStyle(fontSize: screenWidth * 0.05)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenHeight * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Enter Your Budget Settings:',
                style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: _budgetController,
                decoration: const InputDecoration(labelText: 'Total Budget (\$)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.015),
              TextField(
                controller: _usersController,
                decoration: const InputDecoration(labelText: 'Total Users'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.015),
              TextField(
                controller: _rewardController,
                decoration: const InputDecoration(labelText: 'Reward Per User (\$)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _calculate,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calculate'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              if (_maxRewardPerUser != null) ...[
                Text('💡 Max Affordable Reward per User (within budget): \$${_maxRewardPerUser!.toStringAsFixed(2)}'),
                Text('🎯 Max Users You Can Fully Reward (within budget): $_maxUsersCovered'),
                Text('📅 Planned Total Cost (All Users Redeem): \$${_totalCostIfAllUsersSucceed!.toStringAsFixed(2)}'),
                SizedBox(height: screenHeight * 0.02),
                if (_totalCostIfAllUsersSucceed! <= (double.tryParse(_budgetController.text) ?? 0))
                  const Text(
                    '✅ Your plan is within the budget.',
                    style: TextStyle(color: Colors.green),
                  )
                else
                  const Text(
                    '⚠️ Warning: Your current plan would exceed your budget.\nPlease reduce rewards, users, or increase your budget.',
                    style: TextStyle(color: Colors.red),
                  ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/transaction.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = TransactionStorage.expenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Расходы'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Добавить расход',
            onPressed: () => context.push('/add-expense'),
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: 'Перейти к пополнениям',
            onPressed: () => context.go('/incomes'),
          ),
        ],
      ),
      body: expenses.isEmpty
          ? const Center(child: Text('Пока нет расходов'))
          : ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, i) {
          final tx = expenses[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(tx.imageUrl)),
              title: Text(tx.title),
              subtitle: Text(tx.source),
              trailing: Text(
                '-${tx.amount.toStringAsFixed(2)} ₽',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}

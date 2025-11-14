import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/transaction.dart';

class IncomeListScreen extends StatelessWidget {
  const IncomeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final incomes = TransactionStorage.incomes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Пополнения'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Добавить пополнение',
            onPressed: () => context.push('/add-income'),
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: 'Перейти к расходам',
            onPressed: () => context.go('/expenses'),
          ),
        ],
      ),
      body: incomes.isEmpty
          ? const Center(child: Text('Пока нет пополнений'))
          : ListView.builder(
        itemCount: incomes.length,
        itemBuilder: (context, i) {
          final tx = incomes[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(tx.imageUrl)),
              title: Text(tx.title),
              subtitle: Text(tx.source),
              trailing: Text(
                '+${tx.amount.toStringAsFixed(2)} ₽',
                style: const TextStyle(color: Colors.green),
              ),
            ),
          );
        },
      ),
    );
  }
}

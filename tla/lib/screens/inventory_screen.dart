import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/inventory_provider.dart';
import '../models/inventory_item.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory = ref.watch(inventoryProvider);

    final nameController = TextEditingController();
    final quantityController = TextEditingController();
    final descriptionController = TextEditingController();

    void addItem() {
      final name = nameController.text;
      final quantity = int.tryParse(quantityController.text) ?? 0;
      final description = descriptionController.text;

      if (name.isNotEmpty && quantity > 0) {
        ref.read(inventoryProvider.notifier).addItem(name, quantity, description);
        nameController.clear();
        quantityController.clear();
        descriptionController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Inventory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addItem,
              child: const Text('Add Item'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: inventory.length,
                itemBuilder: (context, index) {
                  final item = inventory[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Quantity: ${item.quantity}\n${item.description}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

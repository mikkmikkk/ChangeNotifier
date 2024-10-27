import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/inventory_item.dart';

class InventoryNotifier extends StateNotifier<List<InventoryItem>> {
  InventoryNotifier() : super([]);

  void addItem(String name, int quantity, String description) {
    state = [
      ...state,
      InventoryItem(name: name, quantity: quantity, description: description),
    ];
  }
}

final inventoryProvider = StateNotifierProvider<InventoryNotifier, List<InventoryItem>>((ref) {
  return InventoryNotifier();
});

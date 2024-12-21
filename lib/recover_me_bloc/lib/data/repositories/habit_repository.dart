import 'package:recover_me_bloc/database/database_helper.dart';

class HabitRepository {
  final DatabaseHelper _dbHelper;

  HabitRepository(this._dbHelper);

  Future<void> addHabit(String name, int target) async {
    await _dbHelper.insertHabit({
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnTarget: target,
      DatabaseHelper.columnCurrent: 0,
    });
  }

  Future<List<Map<String, dynamic>>> getHabits() async {
    return await _dbHelper.getHabits();
  }

  Future<void> deleteHabit(int id) async {
    final deletedRows = await _dbHelper.deleteHabit(id);
    if (deletedRows == 0) {
      throw Exception('Failed to delete habit: No habit found with ID $id');
    }
  }

  Future<void> updateHabit(int id, int currentValue) async {
    final updatedRows = await _dbHelper.updateHabit(id, currentValue);
    if (updatedRows == 0) {
      throw Exception('Failed to update habit: No habit found with ID $id');
    }
  }
}

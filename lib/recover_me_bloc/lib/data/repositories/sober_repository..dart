import 'package:recover_me_bloc/database/database_helper.dart';

class SoberRepository {
  final DatabaseHelper _databaseHelper;

  SoberRepository(this._databaseHelper);

  Future<int> getSoberDays() async {
    return await _databaseHelper.getSoberDays();
  }

  Future<void> updateSoberDays(int newSoberDays) async {
    await _databaseHelper.updateSoberDays(newSoberDays);
  }

  Future<void> resetSoberDays() async {
    await updateSoberDays(0); 
  }
}

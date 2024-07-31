abstract class Storage<T> {
  T readData(String key);
  Future<void> saveData(String key, dynamic value);
  Future deleteData({key});
}

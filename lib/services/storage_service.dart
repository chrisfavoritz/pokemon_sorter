abstract class StorageService {
  Future<int?> getLeftCardNumber();
  Future<void> saveLeftCardNumber(int lcn);
  Future<int?> getRightCardNumber();
  Future<void> saveRightCardNumber(int lcn);
}
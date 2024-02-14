Future<List<WalletNote>> loopWalletNotes(List data) async {
  List<WalletNote> _arr = [];
  for (var item in data) _arr.add(WalletNote.fromAPI(item));
  return _arr;
}

class WalletNote {
  int id = 0;
  String slug = '';
  String name = '';
  String desc = '';

  WalletNote({
    this.id = 0,
    this.slug = '',
    this.name = '',
    this.desc = '',
  });

  WalletNote.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.name = data['name'];
    } catch (e) {}
    try {
      this.desc = data['desc'];
    } catch (e) {}
  }
}

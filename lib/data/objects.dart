import 'package:uuid/uuid.dart';

class Objects {
  Uuid id;
  String name;
  int quantity;
  bool selected;

  Objects.empty() {
    this.id = Uuid();
    this.selected = false;
  }

  Objects(String name, int quantity, bool selected) {
    this.id = Uuid();
    this.name = name;
    this.quantity = quantity;
    this.selected = selected; //usually 'false'
  }
}

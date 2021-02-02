import 'package:SearchIt/data/objects.dart';

class HomepageArguments {
  final bool itemsPage;

  HomepageArguments(this.itemsPage);
}

class ItempageArguments {
  final ListedObject parent;

  ItempageArguments(this.parent);
}

class EditHomeArguments {
  final Home home;

  EditHomeArguments(this.home);
}

class EditItemArguments {
  final ListedObject parent;
  final Item item;

  EditItemArguments(this.parent, this.item);
}
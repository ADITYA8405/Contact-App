import 'package:flutter/material.dart';
import 'package:contactapp/model/contact.dart';
import 'package:contactapp/database/database_helper.dart';

class ContactProvider extends ChangeNotifier {//This is the secret sauce. By extending this class, ContactProvider gains the ability to "shout" to the rest of the app whenever data changes using the notifyListeners() method.
  
  List<Contact> contacts = []; //This is your local "source of truth." The UI will look at this list to decide what to display.
  List<Contact> filteredContacts = [];//new list for searching 
  DatabaseHelper dbHelper = DatabaseHelper();//is is the bridge to your actual database (likely SQLite). The Provider doesn't handle raw SQL; it asks the helper to do the heavy lifting.

  // LOAD
  Future<void> loadContacts() async { //It fetches raw data (usually a list of Maps) from the database.
    final data = await dbHelper.getContacts();

    contacts = data.map((item) { //converts those Maps into a List<Contact> objects so your Flutter code can use dot notation (like contact.name) instead of keys.
      return Contact(
        id: item['id'],
        name: item['name'],
        contact: item['contact'],
      );
      
    }).toList();
    filteredContacts = contacts; //for filtering the contacts

    notifyListeners(); //his is the "Update" button. It tells every widget listening to this Provider, "Hey! The list changed! Redraw yourself right now!"
  }

  // ADD
  Future<void> addContact(String name, String contact) async {
    await dbHelper.insertContact(name, contact);
    await loadContacts();
  }

  // UPDATE
  Future<void> updateContact(int id, String name, String contact) async {
    await dbHelper.updateContact(id, name, contact);
    await loadContacts();
  }

  // DELETE
  Future<void> deleteContact(int id) async {
    await dbHelper.deleteContact(id);
    await loadContacts();
  }

//Search
void searchContacts(String query) {
  if (query.isEmpty) {
    filteredContacts = contacts;
  } else {
    filteredContacts = contacts.where((contact) {
      return contact.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  notifyListeners();
}
//f search empty → show all
// Else → filter names







}

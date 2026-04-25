// import 'package:contactapp/contact.dart';
// import 'package:contactapp/databse_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:contactapp/contacts_proivder.dart';
// import 'package:provider/provider.dart';


// //DatabaseHelper dbHelper = DatabaseHelper();

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController contactController = TextEditingController();

//   int selectedIndex = -1;

//   @override
// void initState() {
//   super.initState();
//   Future.microtask(() =>
//       Provider.of<ContactProvider>(context, listen: false).loadContacts());
// }

//   // LOAD DATA
//  // void loadContacts() 
  

//   @override
 
//   Widget build(BuildContext context ) {
    
//      final provider = Provider.of<ContactProvider>(context);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Contact List')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0), // ✅ fixed
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 hintText: "Contact Name",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: contactController,
//               keyboardType: TextInputType.number,
//               maxLength: 10,
//               decoration: const InputDecoration(
//                 hintText: "Contact Number",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // BUTTONS
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // SAVE BUTTON
//                 ElevatedButton(
//                   onPressed: () async {
//                       final provider =
//       Provider.of<ContactProvider>(context, listen: false);
//                     String name = nameController.text.trim();
//                     String contact = contactController.text.trim();

//                     if (name.isNotEmpty && contact.isNotEmpty) {
//                       await provider.addContact(name, contact);

//                       nameController.clear();
//                       contactController.clear();

//                     }
//                   },
//                   child: const Text("Save"),
//                 ),

//                 const SizedBox(width: 10),

//                 // UPDATE BUTTON
//                 ElevatedButton(
//                   onPressed: () async {
//                     String name = nameController.text.trim();
//                     String contact = contactController.text.trim();

//                     if (name.isNotEmpty &&
//                         contact.isNotEmpty &&
//                         selectedIndex != -1) {
//                       await provider.updateContact(
//                         provider.contacts[selectedIndex].id!,
//                         name,
//                         contact,
//                       );

//                       nameController.clear();
//                       contactController.clear();

//                       selectedIndex = -1;

                    
//                     }
//                   },
//                   child: const Text("Update"),
//                 ),
//               ],
//             ),


// //search contact

//             TextField(
//   decoration: InputDecoration(
//     hintText: "Search contact...",
//     border: OutlineInputBorder(),
//   ),
//   onChanged: (value) {
//     Provider.of<ContactProvider>(context, listen: false)
//         .searchContacts(value);
//   },
// ),

//             // LIST
//            provider.contacts.isEmpty
//                 ? const Text('No contacts yet..')
//                 : Expanded(
//                     child: ListView.builder(
//                       itemCount: provider.filteredContacts.length,
//                       itemBuilder: (context, index) => getRow(index, provider),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ROW UI
//   Widget getRow(int index,ContactProvider provider) {
//     return Card(
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor:
//               index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple, 
//           foregroundColor: Colors.white,
//           child: Text(
//            provider.contacts[index].name[0],
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),

//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//             provider. filteredContacts[index].name,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(provider.filteredContacts[index].contact),
//           ],
//         ),

//         trailing: SizedBox(
//           width: 70,
//           child: Row(
//             children: [
//               // EDIT
//               InkWell(
//                 onTap: () {
//                   nameController.text = provider.filteredContacts[index].name;
//                   contactController.text = provider.filteredContacts[index].contact;

//                   setState(() {
//                     selectedIndex = index;
//                   });
//                 },
//                 child: const Icon(Icons.edit),
//               ),

//               // DELETE
//               InkWell(
//                 onTap: () async {
//                   await provider.deleteContact(provider.filteredContacts[index].id!);
                
//                 },
//                 child: const Icon(Icons.delete),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// //dbhelper kya tha
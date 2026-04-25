import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contactapp/provider/contacts_proivder.dart';
import 'package:provider/provider.dart';

class Homepage2 extends StatefulWidget {
  const Homepage2({super.key});

  @override
  State<Homepage2> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage2> {
  TextEditingController nameController    = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController searchController  = TextEditingController();

  int  selectedIndex = -1;
  bool _showForm     = false;

  // ── Palette ──────────────────────────────────────────────
  static const Color _bg        = Color(0xFFF5F5F7);
  static const Color _white     = Color(0xFFFFFFFF);
  static const Color _accent    = Color(0xFF3D8EF0);
  static const Color _accentBg  = Color(0xFFEAF2FE);
  static const Color _danger    = Color(0xFFFF453A);
  static const Color _textHead  = Color(0xFF1C1C1E);
  static const Color _textSub   = Color(0xFF6C6C70);
  static const Color _border    = Color(0xFFE5E5EA);
  static const Color _fill      = Color(0xFFF2F2F7);

  static const List<Color> _avatarColors = [
    Color(0xFF5E5CE6),
    Color(0xFF30B0C7),
    Color(0xFF34C759),
    Color(0xFFFF9F0A),
    Color(0xFFFF6B6B),
    Color(0xFFBF5AF2),
    Color(0xFF3D8EF0),
    Color(0xFFFF7043),
  ];

  Color _avatarColor(int i) => _avatarColors[i % _avatarColors.length];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ContactProvider>(context, listen: false).loadContacts());
  }

  void _openForm({bool editing = false}) {
    setState(() => _showForm = true);
    if (!editing) {
      nameController.clear();
      contactController.clear();
    }
  }

  void _closeForm() {
    setState(() {
      _showForm     = false;
      selectedIndex = -1;
    });
    nameController.clear();
    contactController.clear();
    FocusScope.of(context).unfocus();
  }

  // ── Root ──────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(provider),
              _buildSearchBar(),
              if (_showForm) _buildForm(provider),
              _buildList(provider),
            ],
          ),
        ),
        floatingActionButton: _showForm ? null : _buildFAB(),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────
  Widget _buildHeader(ContactProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contacts',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: _textHead,
                    letterSpacing: -0.6,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${provider.contacts.length} '
                  '${provider.contacts.length == 1 ? 'contact' : 'contacts'}',
                  style: TextStyle(
                      fontSize: 13, color: _textSub),
                ),
              ],
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _accentBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline_rounded,
                color: _accent, size: 20),
          ),
        ],
      ),
    );
  }

  // ── Search ────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: _white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _border),
        ),
        child: TextField(
          controller: searchController,
          onChanged: (v) {
            Provider.of<ContactProvider>(context, listen: false)
                .searchContacts(v);
            setState(() {});
          },
          style: TextStyle(fontSize: 15, color: _textHead),
          decoration: InputDecoration(
            hintText: 'Search name or number…',
            hintStyle: TextStyle(color: _textSub, fontSize: 14),
            prefixIcon:
                Icon(Icons.search_rounded, color: _textSub, size: 19),
            suffixIcon: searchController.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      searchController.clear();
                      Provider.of<ContactProvider>(context, listen: false)
                          .searchContacts('');
                      setState(() {});
                    },
                    child: Icon(Icons.cancel_rounded,
                        color: _textSub, size: 17),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 11),
          ),
        ),
      ),
    );
  }

  // ── Form Card ─────────────────────────────────────────────
  Widget _buildForm(ContactProvider provider) {
    final isEditing = selectedIndex != -1;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 14, 0),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isEditing ? const Color(0xFFFF9F0A) : _accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  isEditing ? 'Edit Contact' : 'New Contact',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textHead,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _closeForm,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: _fill,
                      shape: BoxShape.circle,
                    ),
                    child:
                        Icon(Icons.close_rounded, size: 15, color: _textSub),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _formField(
              controller: nameController,
              hint: 'Full name',
              icon: Icons.person_outline_rounded,
              inputType: TextInputType.name,
            ),
          ),
          const SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _formField(
              controller: contactController,
              hint: 'Phone number',
              icon: Icons.phone_outlined,
              inputType: TextInputType.phone,
              maxLen: 10,
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: _formBtn(
                    label: isEditing ? 'Update' : 'Save',
                    primary: true,
                    onTap: () async {
                      final name    = nameController.text.trim();
                      final contact = contactController.text.trim();
                      if (name.isEmpty || contact.isEmpty) return;

                      HapticFeedback.mediumImpact();
                      if (isEditing) {
                        await provider.updateContact(
                          provider.contacts[selectedIndex].id!,
                          name,
                          contact,
                        );
                      } else {
                        await provider.addContact(name, contact);
                      }
                      _closeForm();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                _formBtn(
                    label: 'Cancel',
                    primary: false,
                    onTap: _closeForm),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    int? maxLen,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      maxLength: maxLen,
      style: TextStyle(fontSize: 15, color: _textHead),
      cursorColor: _accent,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: _textSub, fontSize: 14),
        prefixIcon: Icon(icon, color: _textSub, size: 19),
        counterText: '',
        filled: true,
        fillColor: _fill,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _accent, width: 1.5),
        ),
      ),
    );
  }

  Widget _formBtn({
    required String label,
    required bool primary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 18),
        decoration: BoxDecoration(
          color: primary ? _accent : _fill,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: primary ? Colors.white : _textSub,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // ── Contact List ──────────────────────────────────────────
  Widget _buildList(ContactProvider provider) {
    if (provider.contacts.isEmpty) return _emptyState();

    final list = provider.filteredContacts;

    if (list.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_off_rounded,
                  size: 36, color: _textSub.withOpacity(0.35)),
              const SizedBox(height: 10),
              Text('No results found',
                  style: TextStyle(color: _textSub, fontSize: 15)),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 2, 16, 100),
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (ctx, i) => _contactCard(i, provider),
      ),
    );
  }

  Widget _contactCard(int index, ContactProvider provider) {
    final contact    = provider.filteredContacts[index];
    final isSelected = selectedIndex == index && _showForm;
    final color      = _avatarColor(index);

    return GestureDetector(
      onTap: () {
        nameController.text    = contact.name;
        contactController.text = contact.contact;
        setState(() {
          selectedIndex = index;
          _showForm     = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected ? _accentBg : _white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _accent.withOpacity(0.3) : _border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.025),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar tile
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.13),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  contact.name[0].toUpperCase(),
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Name + number
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _textHead,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contact.contact,
                    style: TextStyle(fontSize: 13, color: _textSub),
                  ),
                ],
              ),
            ),
            // Edit / Delete
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _iconBtn(
                  icon: Icons.edit_outlined,
                  fg: _accent,
                  bg: _accentBg,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    nameController.text    = contact.name;
                    contactController.text = contact.contact;
                    setState(() {
                      selectedIndex = index;
                      _showForm     = true;
                    });
                  },
                ),
                const SizedBox(width: 7),
                _iconBtn(
                  icon: Icons.delete_outline_rounded,
                  fg: _danger,
                  bg: const Color(0xFFFFEEEE),
                  onTap: () async {
                    HapticFeedback.mediumImpact();
                    await provider.deleteContact(contact.id!);
                    if (selectedIndex == index) _closeForm();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBtn({
    required IconData icon,
    required Color fg,
    required Color bg,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 33,
        height: 33,
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(9)),
        child: Icon(icon, color: fg, size: 16),
      ),
    );
  }

  // ── Empty State ───────────────────────────────────────────
  Widget _emptyState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                  color: _accentBg, shape: BoxShape.circle),
              child: const Icon(Icons.person_add_alt_1_outlined,
                  color: _accent, size: 30),
            ),
            const SizedBox(height: 14),
            Text('No contacts yet',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _textHead)),
            const SizedBox(height: 5),
            Text('Tap + to add your first contact',
                style: TextStyle(fontSize: 13, color: _textSub)),
          ],
        ),
      ),
    );
  }

  // ── FAB ───────────────────────────────────────────────────
  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: _openForm,
      backgroundColor: _accent,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
    );
  }
}
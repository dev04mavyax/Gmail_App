
import 'package:flutter/material.dart';
import 'package:gmailapp/Authentication/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GmailDrawer extends StatelessWidget {
  @override
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear the saved email, password, and token (if any)
    await prefs.clear();

    // Navigate back to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false, // This will remove all routes and make the login screen the new root.
    );
  }
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,

      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Gmail logo and title
            Container(
              height: 120,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text(
                      'EaseSmith',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // "All inboxes" item
            ListTile(
              leading: Icon(Icons.inbox_outlined),
              title: Text('All inboxes',style: TextStyle(
                  fontWeight: FontWeight.w600,fontSize: 15
              ),),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // Section: Primary
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue.shade50
              ),
              child: _buildDrawerItem(
                icon: Icons.inbox,
                label: 'Primary',
                badgeText: '175 new',
                badgeColor: Colors.blue.shade100,
                onTap: () {},
              ),
            ),

            // Section: Promotions
            _buildDrawerItem(
              icon: Icons.local_offer_outlined,
              label: 'Promotions',
              badgeText: '248 new',
              badgeColor: Colors.green.shade100,
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // Section: Social
            _buildDrawerItem(
              icon: Icons.people_alt_outlined,
              label: 'Social',
              badgeText: '28 new',
              badgeColor: Colors.blue.shade100,
              onTap: () {
                Navigator.pop(context);
              },
            ),

            Divider(),

            // Labels section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('All labels', style: TextStyle(color: Colors.grey.shade800,fontSize: 14,fontWeight: FontWeight.w600)),
            ),

            _buildDrawerItem(icon: Icons.star_border_outlined, label: 'Starred', onTap: () {  Navigator.pop(context);}),
            _buildDrawerItem(icon: Icons.watch_later_outlined, label: 'Snoozed', onTap: () {  Navigator.pop(context);}),
            _buildDrawerItem(
              icon: Icons.label_important_outline,
              label: 'Important',
              badgeText: '331',
              badgeColor: Colors.transparent,
              onTap: () {  Navigator.pop(context);},
            ),
            _buildDrawerItem(icon: Icons.send_outlined, label: 'Sent', onTap: () {  Navigator.pop(context);}),
            _buildDrawerItem(icon: Icons.schedule_send_outlined, label: 'Scheduled', onTap: () {  Navigator.pop(context);}),
            _buildDrawerItem(icon: Icons.outbox, label: 'Outbox', onTap: () {  Navigator.pop(context);}),
            _buildDrawerItem(icon: Icons.drafts, label: 'Drafts', badgeText: '3', onTap: () {  Navigator.pop(context);}),
            _buildDrawerItem(icon: Icons.mail_outline_rounded, label: 'All mail', badgeText: '99+', onTap: () {  Navigator.pop(context);}),
            _buildDrawerItem(icon: Icons.report_gmailerrorred_outlined, label: 'Spam', badgeText: '28', onTap: () {  Navigator.pop(context);}),
            _buildDrawerItem(icon: Icons.delete_outlined, label: 'Bin', onTap: () {  Navigator.pop(context);}),

            Divider(),

            _buildDrawerItem(icon: Icons.settings, label: 'Settings', onTap: () {  Navigator.pop(context);}),
            _buildDrawerItem(icon: Icons.logout, label: 'LogOut', onTap: () async {   await _logout(context);}),

          ],
        ),
      ),
    );
  }

  // Method to build individual drawer items
  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    String? badgeText,
    Color? badgeColor,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon,size: 22,),
      title: Text(label,style: TextStyle(
          fontWeight: FontWeight.w600,fontSize: 15
      ),),
      trailing: badgeText != null
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: badgeColor ?? Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          badgeText,
          style: TextStyle(color: Colors.grey.shade800, fontSize: 11,fontWeight: FontWeight.w500),
        ),
      )
          : null,
      onTap: onTap,
    );
  }
}

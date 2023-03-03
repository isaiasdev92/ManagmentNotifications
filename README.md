# Managment Notifications

This small example is used to save information in a json file, initially I created it to save information in the background, since the databases, sqflite, hive, among others when saving the information using isolates using these databases, in the second thread, the main thread did not see these changes. When I speak of the main thread I mean the view, the changes that saved the thread using isolates were only consulted in this thread.

When using a json file, I saw that the changes saved in the thread using isolates were reflected in the main thread.

I did this mainly to save the push notifications that were sent to the user.

# Artmospherez

Weather app using public domain art works to display the current and forthcoming weather. 

I blogged about some changes I made to this app in version 1.1 and version 1.1.1. That blog post can be found at https://iosdevlearnings.wordpress.com/2017/06/04/geocoding-and-timeouts-and-startup/

I blogged about the closure-based buttons and UIGestureRecognizers in version 1.1.1 of the project. That blog post can be found at https://iosdevlearnings.wordpress.com/2017/06/07/closure-buttons-and-gesture-recognizers/

V1.1 currently in the iTunes App Store. Added the following features in first revision:
1. Added **Close** button to the detail screens. (User feedback that it was confusing.)
2. Moved **Info** button on detail screens to make way for the new **Close** button.
3. Improved display and initialization of all labels and buttons in the app.
4. Handled rejected location authorization better. (User feedback that it was confusing.)
5. Reduced refresh timeout, including geocoding. (User feedback that it could get hung up in geocoding phase.)
6. Provided user-facing feedback while downloading. (User feedback that it seemed to hang.)
7. New images for Rainy, Sunny, and Cloudy days (most common weather types).

V1.1.1 currently in development and nearing readiness for submission:
1. Displays current weather as "Clear" instead of "Sunny" at night.
2. Restructured code to be less repetitive, use more advanced Swift language features.
3. "Default" weather location moved to Utqiaġvik (Barrow), Alaska, in case of users not approving location services.
4. Selection of weather images now made taking into acount entire table view instead of per section, preventing two days in a row with the same image.
5. Full support for recent iPhones
6. Increased number of days of forecast to 10

Demonstrated skills:
1. JSONSerialization
2. Parsing JSON into models
3. URLSession
4. Grand Central Dispatch
5. Interface Builder
6. Error Handling
7. Animated UIViewController Transitions
8. CoreLocation
9. Activity Indicator
10. UITableView, custom UITableViewCell
11. Gesture Recognizers
12. Subclassing
13. Inheritance
14. UI/UX
15. MVC
16. File system
17. UserDefaults
18. Apple submission
19. Enums (no associated values though)
20. Switch statements
21. Delegate protocols
22. Common-functionality protocols
23. Default protocol implementations
24. Generics
25. Class extensions
26. Singletons
27. Probably forgot several things, take a look!

background-gps
==============
This demo project was created to test collecting GPS coordinates while iOS app is in background.


## How to use application?
1. Build & Run project
2. Allow to use «Your Current Location»
3. Check either «Background App Refresh» is allowed or not:
  4. go to settings
  5. general
  6. choose «Background App Refresh»
  7. switcher opposite «Background GPS» should be enabled
4. Go back to application and switch on switcher in upper toolbar
5. Now you can collect coordinates while application is in background!

![alt text](http://esmu.lv/background-app-refresh.png "How to find «Background App Refresh»")

## More
You can adjust coordinates update distance by going to `BGMainTVC.m` and in `ViewDidLoad` method change `distanceFilter` property for `self.locationManager` (1.0f == 1 meter).
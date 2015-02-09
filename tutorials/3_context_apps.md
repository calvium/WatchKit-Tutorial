#Context Menus and Modal Dialogs in Apple Watch Apps

##Introduction

So now we've taken a look at how to create both [hierarchical](#) and [paged](#) apps, we can begin to look at some of the more exciting new features inside the WatchKit SDK such as context menus, modal dialogs, and map views.

###Context Menus

It doesn't matter which style of navigation you want to use, context menu's can be added to either. These are up to 4 options that users can do on any given screen, for example order a list alphabetically. 

We need to open the Watch App storyboard and drag a Menu out from the UI Objects onto your Interface Controller, it automatically gives you one menu item however you can add up to a total of 4 items. You can also either pick from a list of provided images, or provide your own icon. You can also provide your own title for the item.

![Imgur](http://i.imgur.com/iLWmHzc.png)

If you run your app again, and long press on the screen for a couple of seconds your menu should appear. It'll do a little animation as the menu is about to appear but don't let go until all your menu items actually appear!

![Imgur](http://i.imgur.com/0kWMHSi.png)

You can hook up each menu item into your interface controller class like you would a usual button press with an IBAction:

```obj-c
- (IBAction)menuMapPressed {
    NSLog(@"pressed map item");
}
```

###Modal Dialogs

Next, we can hook our menu item to display a modal dialog instead of just logging to the console.

First, we need to go back to our storyboard and drag out a new Interface Controller. Next, we need to drag a connection between the first interface controller and the second. It should ask you if you want to create a modal or push segue, pick modal. Give it a useful identifier.

![Imgur](http://i.imgur.com/gTGgzO3.png)

Next, create a new interface controller subclass for your new interface controller.

Then, move back to the Storyboard and after you set your new interface controllers class, also give it a useful identifier. This is how we'll tell our menu item to present the right controller modally.

Finally, inside the interface controller with the menu items ammend the action to do the following:

```obj-c
- (IBAction)menuMapPressed {

    //present the modal dialog
    [self presentControllerWithName:@"MapModalInterface" context:nil];
}
```

###Bonus: Maps

One of the more "frustrating" points of the WatchKit is the lack of features for maps in the WatchKit SDK. In the storyboard view, drag a map from the UI objects onto our new modal interface controller. Hook this up to the subclass so we can access it in code.

If you run the app at the moment nothing very much will happen in our map, so we first must provide it a location (a latitude and longitude) to zoom in on:

```obj-c
[_map setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(51.450265, -2.596797 ), 1500,1500)];
```

Next, you can add up to 5 annotations and these can be with your own custom images:

```obj-c
[_map addAnnotation:CLLocationCoordinate2DMake(51.450265, -2.596797 ) withPinColor:WKInterfaceMapPinColorRed];
```

However, this is where the features pretty much stop. It's impossible for the user to pan around the map or zoom and out, it's also not possible to interact with annotations and display any additional information.

![Imgur](http://i.imgur.com/8oI3fkS.png)

##Conclusion

All my project code is available on GitHub at https://github.com/calvium/WatchKit-Tutorial if you got stuck or want to see what I did. Next we're going to look at how we can share data from the iPhone app to the Apple Watch app using extension groups and NSUserDefaults!
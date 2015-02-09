# Sharing Data between Apple Watch and iPhone Apps

## Introduction

So we've had a look at how we can do a lot of things with the WatchKit SDK and making our own Apple Watch Apps, however the next thing to look at is how to communicate between the iPhone and Apple Watch app. To do this we'll have to create an App Group which is essentially a space which both apps can use which was brought in with the exetension framework. 

### Add Capabilities

The first thing we need to do is add "App Group" capabilities to both our iPhone app and Watch Extension targets.

To do this open up the project settings (blue icon at the top of the list of files) and select the iPhone target. You will need to select the "capabilities" tab at the top of the page and scroll down to turn on app groups.

This requires a connected developer profile, and will take a while to enable. You'll need to do the same steps to switch on app groups for the watch kit extension also.

Next you need to ensure that the app group string is an identifier string you want and that makes sense for your app, it must start with the word group or it complains. You can also add multiple groups if you wish. Whatever you pick they must be enabled with a blue tick (again this might take a while) and are **exactly the same** for both the iPhone and Watch extension targets!

![Imgur](http://i.imgur.com/eTszOm4.png)
> I've enabled an app group with the identifier "group.com.calvium.watch.dev.defaults"


### iPhone NSUserDefaults

Now if we want to write to our app group using NSUserDefaults in the iPhone app we can do the following on our view did load:

```obj-c
//use our group user defaults
NSUserDefaults *defaults = [[NSUserDefaults alloc] 	
    initWithSuiteName:@"group.com.calvium.watch.dev.defaults"];

//set a greeting
[defaults setObject:@"hello!" forKey:@"greeting"];

//synchronise
[defaults synchronize];
```

Next, inside our Watch Extension, inside the first interface controller and the awake with context, we can get the saved defaults:

```obj-c
//use our group user defaults
NSUserDefaults *defaults = [[NSUserDefaults alloc] 
    initWithSuiteName:@"group.com.calvium.watch.dev.defaults"];

//get the greeting    
NSString *greeting = [defaults objectForKey:@"greeting"];

//check if greeting isn't empty
if (greeting) {
    NSLog(@"greeting = %@", greeting);
} else{
    NSLog(@"no user defaults :(");
}
```

Finally, you'll need to run the iPhone target BEFORE running the Watch Extension to be able to test if your code worked!

## Conclusion

All my project code is available on GitHub at https://github.com/calvium/WatchKit-Tutorial if you got stuck or want to see what I did. Next we're going to put sharing data between the iPhone and Apple Watch to good use by looking at how Glances work!
# Glances in Apple Watch

## Introduction
So last time we learned how to synchronise data between our iPhone and Watch app, this week we're going to look at using that to set up glances. Glances enable us to display timely and relevant data to our users, for our example we're going to show the user whatever colour they were last looking at on the iPhone app.

The official documentation for glances suggests using timers to periodically update the data the glance is displaying. How often your app checks for updates is up to you however, I wouldn't do it too often or the user might uninstall your app for consuming too much battery power.

### Running Glances

Firstly, we need to tell our emulator to run the "glances" mode and not the proper Apple Watch App. To do this click on the target for the emulator (bit to the left of which device your going to run on) and press edit scheme. 

Here you want to change the executable to be the "glance":

![Imgur](http://i.imgur.com/CyFj49w.png)

Now we need to make it do something!

### iPhone App

I'm going to make a simple iPhone app with a list of colours. When the user selects one it'll display full screen the colour and also update the user defaults to the colour selected.

### Glance Storyboard

All glances must have two groups of information, and they cannot scroll. We're going to set up our glance to have a top title label, to display in text the colour we're displaying below in a group:

![Imgur](http://i.imgur.com/MP5F0Dy.png)

### Glance Code

First, we need to set up a link between our title label and our group.

Next, we should create a function to get out whatever is in our user defaults and change the title and group background colour appropriately:

```obj-c
-(void) getUserDefaults
{
    //use our group user defaults
    NSUserDefaults *defaults = [[NSUserDefaults alloc] 
    	initWithSuiteName:@"group.com.calvium.watch.dev.defaults"];
    
    //get the colour
    NSString *textColour = [defaults objectForKey:@"colour"];
    
    if (textColour) {
        [_lblTitle setText:textColour];
        [self setColour:textColour];
    } else {
        [_lblTitle setText:@"not set yet"];
        [_group setBackgroundColor:[UIColor darkGrayColor]];
    }
}
```

Finally, if we want to keep our glance up to date we'll have to set up a timer. This is from the official Apple Docs:

>To update the content of a glance after it is onscreen, use an NSTimer object to perform periodic updates. You do not need to update WKInterfaceDate and WKInterfaceTimer objects, which automatically update themselves.


So when our view appears we can start a timer to update every 5 seconds:

```obj-c
//schedule a time to check every 5 seconds
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self 
    	selector:@selector(getUserDefaults) userInfo:nil repeats:YES];
```

Then as soon as our user no longer cares about our glance, we can stop our timer by invalidating it:

```obj-c
//kill our timer!
[_timer invalidate];
```

Now when you run your Watch App, you can interact with the iPhone app and you should see updates happen fairly frequently!

![Imgur](http://i.imgur.com/GsfOTvZ.png)

## Conclusion

So that's the last of our introduction guide to Apple's WatchKit SDK, again all my project code is available on GitHub at https://github.com/calvium/WatchKit-Tutorial if you got stuck or want to see what I did. We're now waiting excitedly to get our hands our own Apple Watch!
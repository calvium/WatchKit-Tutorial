#Hierarchical Apple Watch Apps

##Introduction

Now we've got [our project set up](#) we can start to write some code! Today we're going to take a look at creating a heirarchical Apple Watch App using tables and segues. 

###1. Storyboard

Firstly, we're going to start by removing whatever we had on our app interface. We then want to drag out a **Table** from the UI object items - this should automtically create you a "row" and a "group". The row is like a UITableCell in a UITableVIew, however the group will hold all the UI items for us. Next, we want to drag out a **Label** on to our table - I positioned mine to go horizontally and vertically central.

![Imgur](http://i.imgur.com/yksF7Rq.png)
> This is how my storyboard looks

###2. SubClass Row

We should now subclass our row, so we can set up the label title dynamically. First, in the top toolbar click File - new File - Cocoa Toach Class. I called mine a ColourTableRow and subclassed NSObject. Note, before pressing add you want to make sure you add the file to both Watch App and Watch Extension target!

Next, back in the Storyboard view, click on the TableRowController in the Document Outline - and **set the class** to be the one you just created.

Whilst you in the TableRowController you should also set the **identifier** - these are essentially the same as as a UITableCell's reusable identifier so we can use them later!

Now, open the SubClass **.h** file - we want to create a setter for our label

```obj-c
-(void) setTitle:(NSString *) title;
```

Next we need to open our **.m** file - we firstly want to set an interface and create an outlet for our Label. You might as this point also need to include the WatchKit SDK if it didn't automatically:

```obj-c
#import <WatchKit/WatchKit.h>

@interface DEV_ColourTableRow()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblTitle;
@end
```

Next inside the implementation, we can write the code to set our label to whatever text we provide:

```obj-c
-(void) setTitle:(NSString *)title
{
    [_lblTitle setText:title];
    
}
```

![Imgur](http://i.imgur.com/yR2Va5U.png)
> This is how my storyboard interface now looks

###2. Interface Controller

Now the fun bit - to make some rows actually appear when we run our app! First, we need to open the **InterfaceController.m** file and create an outlet for our table. Whilst we're here we can create two arrays to hold label text, and a UIColor - we could have done this using a custom class but I wanted something that was simple to see.

```obj-c
@property (weak, nonatomic) IBOutlet WKInterfaceTable *table; //link to our table
@property (strong, nonatomic) NSMutableArray *colourTitles; //array of NSString colour titles
@property (strong, nonatomic) NSMutableArray *colours; //array of UIColors
```

Next, I initialised all my arrays with some colour values:

```obj-c
//1. set up our arrays
    _colours = [[NSMutableArray alloc] initWithObjects:
                [UIColor redColor], [UIColor orangeColor], [UIColor yellowColor],
                [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor],
                nil];
    
    _colourTitles = [[NSMutableArray alloc] initWithObjects:@"Red", @"Orange", @"Yellow",
                     @"Green", @"Blue", @"Purple",  nil];
```

So, WatchKit doesn't currently have any delegates or data sources, so we need to **explicilty tell our table how many rows** it will be holding of what type which matches the identifier of the row controller. I'll show you at the end of this post how to set up multiple row types.

```obj-c
//2. Set number of rows in our table
    [_table setNumberOfRows:[_colourTitles count]withRowType:@"ColourRow"];
```

Then, we can **loop through all the rows** we have and set the text:

```obj-c
//3. Loop through each row and set the title
    for (int i = 0; i < [_colourTitles count]; i++){
        DEV_ColourTableRow *colourRow = [_table rowControllerAtIndex:i];
        
        [colourRow setTitle:[_colourTitles objectAtIndex:i]];
        
    }
```

![Imgur](http://i.imgur.com/gzW7EZ3.png)
> When you run your app it should look like this

###3. Push Segue

First, open the interface builder, and drag out another Interface Controller next to your original app interface. To create a segue, we need to connect the **table row controller** with the next screen, **not the entire table**. You should also set up a segue identifier whilst this bit is open.

![Imgur](http://i.imgur.com/2y45iFA.png)
> Segue between the table row controller and the next interface controller

Next, we need to subclass our new Interface controller - you want to subclass a WKInterfaceController and ensure you add it to the Watch App and Watch Extension targets. We also want to drag out a group onto the interface controller as there is now current way programmatically to change the background color - this group also needs to be "relative to container" so that it fills all the space available!

Now, if we open the new interface controller **.m** file, we need to set up an outlet between the group and class. Next, we should look at the awakeWithContext. This passes a context object of type id - this is whatever the previous screen will have sent us. We're intending to send a UIColor so we can do the following:

```obj-c
    //get the colour from context
    UIColor *colour = context;
    
    //set the background colour
    [_group setBackgroundColor:colour];
```

The final piece of the puzzle is going back to the original interface controller **.m** file and implementing the following function:

```obj-c
-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier 
                           inTable:(WKInterfaceTable *)table 
                          rowIndex:(NSInteger)rowIndex
{
    if ([segueIdentifier isEqualToString:@"heirarchicalToColour"]){
        return [_colours objectAtIndex:rowIndex];
    } else {
        return nil;
    }
}
```

This allows us to check what segue is about to be performed, and send the colour corresponding to the row index to the next controller. 

Hopefully if you run your app again you should be able to tap on a row and view it's colour!

###4. Bonus - multiple table row types...

It's possible to use multiple row types in a single table, for example you could have a "loading" row whilst data is being retrieved, or add a heading row. I'm going to make a heading row for my table, by copying and pasting the ColourRow in the document outline in the storyboard. I also need to remove the subclass and give it an identifier.

Next, where we originally told our table how many rows we'd have of type ColourRow, we can give it an array of types. This however, is a little tedious as we want to give it 1 HeadingRow and 6 ColourRows. I cheated and created a loop over all my colour titles to add a row for it like this:

```obj-c
    //add our heading row
    [controllers addObject:@"HeadingRow"];
    
    //add a row for each item in colour titles
    for (NSString *i in _colourTitles){
        [controllers addObject:@"ColourRow"];
    }
    
    //set the row types
    [_table setRowTypes:controllers];
```

Next, we need to loop over all the ColourRows to set the titles, node that the rowControlleratIndex is now +1

```obj-c
    //Loop through each row and set the title
    for (int i = 0; i < [_colourTitles count]; i++){
        
        //like previously, but start at index 1!
        DEV_ColourTableRow *colourRow = [_table rowControllerAtIndex:i+1];
        
        [colourRow setTitle:[_colourTitles objectAtIndex:i]];
        
    }
```

Finally, as your segue was connected to a specific row type we don't need to do much but edit which index of the colours we're providing the next context!

##Conclusion

All my project code is available on GitHub at https://github.com/calvium/WatchKit-Tutorial if you got stuck or want to see what I did. Next we're going to take a look at what a paged app might look like.

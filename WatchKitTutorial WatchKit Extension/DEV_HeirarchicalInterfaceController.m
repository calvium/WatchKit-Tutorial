//
//  DEV_HeirarchicalInterfaceController.m
//  WatchKitTutorial
//
//  Created by danielle vass on 02/02/2015.
//  Copyright (c) 2015 Calvium Ltd. All rights reserved.
//

#import "DEV_HeirarchicalInterfaceController.h"
#import "DEV_ColourTableRow.h"

@interface DEV_HeirarchicalInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *table; //link to our table
@property (strong, nonatomic) NSMutableArray *colourTitles; //array of NSString colour titles
@property (strong, nonatomic) NSMutableArray *colours; //array of UIColors
@end


@implementation DEV_HeirarchicalInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    
    //1. set up our arrays
    _colours = [[NSMutableArray alloc] initWithObjects:
                [UIColor redColor], [UIColor orangeColor], [UIColor yellowColor],
                [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor],
                nil];
    
    _colourTitles = [[NSMutableArray alloc] initWithObjects:@"Red", @"Orange", @"Yellow",
                     @"Green", @"Blue", @"Purple",  nil];
    
    
    //////FOR ONE TYPE OF ROW
    /*
    //2. Set number of rows in our table
    [_table setNumberOfRows:[_colourTitles count]withRowType:@"ColourRow"];
    
    
    
    //3. Loop through each row and set the title
    for (int i = 0; i < [_colourTitles count]; i++){
        DEV_ColourTableRow *colourRow = [_table rowControllerAtIndex:i];
        
        [colourRow setTitle:[_colourTitles objectAtIndex:i]];
        
    }*/
    
    
    //////FOR MULTIPLE TYPES OF ROWS
    
    //set up the controllers
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    
    //add our heading row
    [controllers addObject:@"HeadingRow"];
    
    //add a row for each item in colour titles
    for (NSString *i in _colourTitles){
        [controllers addObject:@"ColourRow"];
    }
    
    //set the row types
    [_table setRowTypes:controllers];
    
    //Loop through each row and set the title
    for (int i = 0; i < [_colourTitles count]; i++){
        
        //like previously, but start at index 1!
        DEV_ColourTableRow *colourRow = [_table rowControllerAtIndex:i+1];
        
        [colourRow setTitle:[_colourTitles objectAtIndex:i]];
        
    }
    
    
    //////NSUserDefaults
    
    //use our group user defaults
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.calvium.watch.dev.defaults"];
    
    //get the greeting
    NSString *greeting = [defaults objectForKey:@"greeting"];
    
    //check if greeting isn't empty
    if (greeting) {
        NSLog(@"greeting = %@", greeting);
    } else{
        NSLog(@"no user defaults :(");
    }
    
    
    
}


//segue's
-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier
                           inTable:(WKInterfaceTable *)table
                          rowIndex:(NSInteger)rowIndex
{
    //only send the colour if segue matches this!
    if ([segueIdentifier isEqualToString:@"heirarchicalToColour"]){
        
        //ignore the heading row
        return [_colours objectAtIndex:rowIndex -1];
    } else {
        return nil;
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end




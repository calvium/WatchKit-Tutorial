//
//  DEV_ColourInterfaceController.m
//  WatchKitTutorial
//
//  Created by danielle vass on 02/02/2015.
//  Copyright (c) 2015 Calvium Ltd. All rights reserved.
//

#import "DEV_ColourInterfaceController.h"


@interface DEV_ColourInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *group;


@end


@implementation DEV_ColourInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    
    //get the colour from context
    UIColor *colour = context;
    
    //set the background colour
    [_group setBackgroundColor:colour];

    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


- (IBAction)menuMapPressed {
    
    //present the modal dialog
    [self presentControllerWithName:@"MapModalInterface" context:nil];
}

@end




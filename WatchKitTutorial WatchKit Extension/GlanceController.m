//
//  GlanceController.m
//  WatchKitTutorial WatchKit Extension
//
//  Created by danielle vass on 27/01/2015.
//  Copyright (c) 2015 Calvium Ltd. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *group;
@property (nonatomic, strong) NSTimer *timer;
@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
   
    
    [self getUserDefaults];
    
    //schedule a time to check every 5 seconds
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getUserDefaults) userInfo:nil repeats:YES];
    
    
}

-(void) setColour:(NSString *) textColour{

    UIColor *color;
    
    if ([textColour isEqualToString:@"Red"]) {
        color = [UIColor redColor];
    } else if ([textColour isEqualToString:@"Orange"]) {
        color = [UIColor orangeColor];
    } else if ([textColour isEqualToString:@"Yellow"]) {
        color = [UIColor yellowColor];
    } else if ([textColour isEqualToString:@"Green"]) {
        color = [UIColor greenColor];
    } else if ([textColour isEqualToString:@"Blue"]) {
        color = [UIColor blueColor];
    } else if ([textColour isEqualToString:@"Purple"]) {
        color = [UIColor purpleColor];
    } else {
        color = [UIColor darkGrayColor];
    }
    
    [_group setBackgroundColor:color];
}

-(void) getUserDefaults
{
    //use our group user defaults
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.calvium.watch.dev.defaults"];
    
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

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    
    //kill our timer!
    [_timer invalidate];
}

@end




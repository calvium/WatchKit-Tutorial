//
//  DEV_ColourTableRow.m
//  WatchKitTutorial
//
//  Created by danielle vass on 02/02/2015.
//  Copyright (c) 2015 Calvium Ltd. All rights reserved.
//

#import "DEV_ColourTableRow.h"
#import <WatchKit/WatchKit.h>

@interface DEV_ColourTableRow()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblTitle;

@end

@implementation DEV_ColourTableRow

-(void) setTitle:(NSString *)title
{
    [_lblTitle setText:title];
    
}

@end

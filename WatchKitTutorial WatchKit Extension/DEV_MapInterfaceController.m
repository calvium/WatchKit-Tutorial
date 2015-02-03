//
//  DEV_MapInterfaceController.m
//  WatchKitTutorial
//
//  Created by danielle vass on 03/02/2015.
//  Copyright (c) 2015 Calvium Ltd. All rights reserved.
//

#import "DEV_MapInterfaceController.h"


@interface DEV_MapInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;

@end


@implementation DEV_MapInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    
    
    //our office in Bristol!
    float lat = 51.449904f;
    float lon = -2.597108f;
    
    //set the region to these coordinates
    //hint change the 1500 to zoom in or out of the area.
    [_map setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(lat, lon ), 1500,1500)];
    
    
    //add an annotation onto our map
    [_map addAnnotation:CLLocationCoordinate2DMake(lat, lon) withPinColor:WKInterfaceMapPinColorRed];
    
    
    

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




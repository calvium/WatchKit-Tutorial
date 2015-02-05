//
//  DEV_ColourViewController.m
//  WatchKitTutorial
//
//  Created by danielle vass on 05/02/2015.
//  Copyright (c) 2015 Calvium Ltd. All rights reserved.
//

#import "DEV_ColourViewController.h"

@interface DEV_ColourViewController ()

@end

@implementation DEV_ColourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:_colour];
    
    //use our group user defaults
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.calvium.watch.dev.defaults"];
    
    //set a greeting
    [defaults setObject:_textColour forKey:@"colour"];
    
    //synchronise
    [defaults synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

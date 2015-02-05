//
//  ViewController.m
//  WatchKitTutorial
//
//  Created by danielle vass on 27/01/2015.
//  Copyright (c) 2015 Calvium Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //use our group user defaults
     NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.calvium.watch.dev.defaults"];
    
    //set a greeting
    [defaults setObject:@"hello!" forKey:@"greeting"];
    
    //synchronise
    [defaults synchronize];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

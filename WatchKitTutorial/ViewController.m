//
//  ViewController.m
//  WatchKitTutorial
//
//  Created by danielle vass on 27/01/2015.
//  Copyright (c) 2015 Calvium Ltd. All rights reserved.
//

#import "ViewController.h"
#import "DEV_ColourViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIColor *colour;
@property (nonatomic, strong) NSString *textColour;
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

- (IBAction)colourButtonPressed:(UIButton *)sender {
    
    //set the colour based on what button was pressed
    
    _textColour = [sender titleLabel].text;
    
    if ([_textColour isEqualToString:@"Red"]) {
        _colour = [UIColor redColor];
    } else if ([_textColour isEqualToString:@"Orange"]) {
        _colour = [UIColor orangeColor];
    } else if ([_textColour isEqualToString:@"Yellow"]) {
        _colour = [UIColor yellowColor];
    } else if ([_textColour isEqualToString:@"Green"]) {
        _colour = [UIColor greenColor];
    } else if ([_textColour isEqualToString:@"Blue"]) {
        _colour = [UIColor blueColor];
    } else if ([_textColour isEqualToString:@"Purple"]) {
        _colour = [UIColor purpleColor];
    }
    
    
    NSLog(@"%@", _colour);
    
    //perform segue
    
    [self performSegueWithIdentifier:@"showColour" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showColour"]) {
        //pass the colour to the next page
       
        
        DEV_ColourViewController *colourController = (DEV_ColourViewController *)segue.destinationViewController;
        [colourController setColour:_colour];
        [colourController setTextColour:_textColour];
    }
}


@end

//
//  EKToolsExampleViewController.m
//  EKToolsExample
//
//  Created by Keith Ermel on 4/9/14.
//  Copyright (c) 2014 Keith Ermel. All rights reserved.
//

#import "EKToolsExampleViewController.h"
#import "CalendarTools/CalendarTools.h"
#import "EKTools/EKTools.h"


@interface EKToolsExampleViewController ()

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@end

@implementation EKToolsExampleViewController

#pragma mark - Actions

- (IBAction)eventsForOneWeekAction:(id)sender
{
    NSDate *oneWeekAhead = [CalendarTools dateForWeeks:1];
    NSArray *events = [[EKTools sharedEKTools] eventsFromNowUntil:oneWeekAhead];
    
    NSString *message = [NSString stringWithFormat:@"week ahead - retrieved: %d events", (int)events.count];
    NSLog(@"%@", message);
    self.resultsLabel.text = message;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

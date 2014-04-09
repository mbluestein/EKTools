//
//  EKToolsTests.m
//  EKToolsTests
//
//  Created by Keith Ermel on 4/1/14.
//  Copyright (c) 2014 Keith Ermel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EKTools.h"
//#import "CalendarTools/CalendarTools.h"


@interface EKToolsTests : XCTestCase
@end


@implementation EKToolsTests

- (void)test_EKTools_sharedEKTools_returns_an_instance
{
    XCTAssertNotNil([EKTools sharedEKTools], @"EKTools should return a non-nil instance");
}

-(void)test_that_EKTools_init_throws_an_exception
{
    XCTAssertThrows([[EKTools alloc] init], @"EKTools init should throw an exception");
}

-(void)test_that_EKTools_sharedEKTools_returns_a_single_instance
{
    EKTools *toolsA = [EKTools sharedEKTools];
    EKTools *toolsB = [EKTools sharedEKTools];
    XCTAssertTrue(toolsA == toolsB, @"toolsA should be same instance as toolsB");
}

-(void)test_that_createEventWithLength_returns_a_non_nil_result
{
    EKEvent *event = [[EKTools sharedEKTools] createEventWithLength:15];
    XCTAssertNotNil(event, @"event should not be nil");
}

/*
-(void)test_that_createEventWithLength_returns_an_event_that_starts_right_now_when_given_zero
{
    NSDate *now = [NSDate date];
    EKEvent *event = [[EKTools sharedEKTools] createEventWithLength:0];
    XCTAssertNotNil(event, @"event should not be nil");
    
    NSCalendarUnit units = NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *nowComps = [CalendarTools components:units forDate:now];
    NSDateComponents *eventCompsStart = [CalendarTools components:units forDate:event.startDate];
    XCTAssertTrue(nowComps.hour == eventCompsStart.hour, @"week values should be equal");
    
    NSDateComponents *eventCompsEnd = [CalendarTools components:units forDate:event.endDate];
    XCTAssertTrue(eventCompsStart.hour == eventCompsEnd.hour, @"hour values should be equal");
    XCTAssertTrue(eventCompsStart.minute == eventCompsEnd.minute, @"minute values should be equal");
}
*/
@end

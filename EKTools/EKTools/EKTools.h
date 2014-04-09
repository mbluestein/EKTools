//
//  EKTools.h
//  EKTools
//
//  Created by XD on 4/1/14.
//  Copyright (c) 2014 Keith Ermel. All rights reserved.
//

#import <Foundation/Foundation.h>
@import EventKit;


typedef void(^EKAuthorized)();
typedef void(^EKUnauthorized)(EKAuthorizationStatus status);


@interface EKTools : NSObject

+(id)sharedEKTools;

/* Asynchronously checks the authorization status for access to the Calendar.
 Note that both blocks are called off of the main queue, so any UI related
 work will need to be wrapped in a block that runs on the main queue. */
-(void)authorizationStatus:(EKAuthorized)authorized unauthorized:(EKUnauthorized)unauthorized;

/* Returns the events from the current date/time until the given end date */
-(NSArray *)eventsFromNowUntil:(NSDate *)endDate;

/* Returns the events from the given start date to the given end date */
-(NSArray *)eventsFromStartDate:(NSDate *)startDate toEndDate:(NSDate *)endDate;

/* Returns a new event starting now lasting the given length of time */
-(EKEvent *)createEventWithLength:(NSInteger)eventLength;
@end

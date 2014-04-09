//
//  EKTools.m
//  EKTools
//
//  Created by XD on 4/1/14.
//  Copyright (c) 2014 Keith Ermel. All rights reserved.
//

#import "EKTools.h"
#import "CalendarTools/CalendarTools.h"


static EKTools *sharedInstance = nil;
static dispatch_once_t initializationLock;

@interface EKTools ()
@property (strong, readonly) EKEventStore *eventStore;
@end


@implementation EKTools

#pragma mark - Public API

+(id)sharedEKTools
{
    dispatch_once(&initializationLock, ^{sharedInstance = [[EKTools alloc] initInternal];});
    return sharedInstance;
}

-(void)authorizationStatus:(EKAuthorized)authorized unauthorized:(EKUnauthorized)unauthorized
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (status) {
        case EKAuthorizationStatusNotDetermined:
            [self requestAccessToEKStore:authorized unauthorized:unauthorized];
            break;
            
        case EKAuthorizationStatusAuthorized:
            authorized();
            break;
            
        default:
            unauthorized(status);
            break;
    }
}

-(NSArray *)eventsFromNowUntil:(NSDate *)endDate
{
    return [self eventsFromStartDate:[NSDate date] toEndDate:endDate];
}

-(NSArray *)eventsFromStartDate:(NSDate *)startDate toEndDate:(NSDate *)endDate
{
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    return [self.eventStore eventsMatchingPredicate:predicate];
}

-(EKEvent *)createEventWithLength:(NSInteger)eventLength
{
    EKEvent *event = [EKEvent eventWithEventStore:self.eventStore];
    event.startDate = [NSDate date];
    event.endDate = [CalendarTools dateByAddingMinutes:eventLength];
    event.calendar = self.eventStore.defaultCalendarForNewEvents;
    return event;
}


#pragma mark - Internal API

-(void)requestAccessToEKStore:(EKAuthorized)authorized unauthorized:(EKUnauthorized)unauthorized
{
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {authorized();}
        else unauthorized(EKAuthorizationStatusDenied);
    }];
}


#pragma mark - Initialization

- (id)initInternal
{
    self = [super init];
    if (self) {_eventStore = [[EKEventStore alloc] init];}
    return self;
}

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"There can only be one MoneypennyAppDefaults instance."
                                 userInfo:nil];
    return nil;
}

@end

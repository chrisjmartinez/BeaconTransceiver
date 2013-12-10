//
//  Guest.m
//  
//
//  Created by Chris Martinez on 12/10/13.
//
//

#import "Guest.h"

@implementation Guest

+ (NSArray *)guestsFromJSON:(NSDictionary *)json {
/*
 Sample payload
 payload =     (
 {
 addstamp = "2013-12-10T20:45:12.367801294Z";
 chgstamp = "2013-12-10T21:04:43.758531504Z";
 "guest_id" = Graham;
 id = "gsl::600a37b6-2be8-4a28-a54f-c915d9a01b56";
 "is_active" = 1;
 "location_id" = "com.stokedsoftware.diningRegion";
 objtype = GuestLocation;
 proximity = 0;
 },
 {
 addstamp = "2013-12-10T20:42:48.267778967Z";
 chgstamp = "2013-12-10T21:04:43.765595701Z";
 "guest_id" = Graham;
 id = "gsl::8106d425-afd7-459e-bd36-69ba5270e546";
 "is_active" = 1;
 "location_id" = "com.stokedsoftware.tennisRegion";
 objtype = GuestLocation;
 proximity = 0;
 },
 {
 addstamp = "2013-12-10T20:45:12.366881426Z";
 chgstamp = "2013-12-10T21:04:43.759143271Z";
 "guest_id" = Graham;
 id = "gsl::cfebd8a3-f9aa-45f7-90a2-4195a0984b70";
 "is_active" = 1;
 "location_id" = "com.stokedsoftware.diningRegion";
 objtype = GuestLocation;
 proximity = 0;
 },
 {
 addstamp = "2013-12-10T20:42:48.268142311Z";
 chgstamp = "2013-12-10T21:04:43.76577975Z";
 "guest_id" = Graham;
 id = "gsl::e72b4451-e793-41e9-92dc-32840eb6548f";
 "is_active" = 1;
 "location_id" = "com.stokedsoftware.spaRegion";
 objtype = GuestLocation;
 proximity = 0;
 }
 );

 */
    NSMutableArray * guests = [NSMutableArray array];
    NSArray * payload = [json objectForKey:@"payload"];
    for (id obj in payload) {
        Guest * guest = [Guest new];
        
        guest.ID = [obj objectForKey:@"guest_id"];
        guest.locationID = [obj objectForKey:@"location_id"];
        guest.proximity = [[obj objectForKey:@"proximity"] integerValue];
        
        [guests addObject:guest];
    }
    
    return guests;
}

@end

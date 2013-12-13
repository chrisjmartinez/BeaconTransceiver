//
//  LocationWebservice.h
//  
//
//  Created by Chris Martinez on 12/8/13.
//
//

#import "BaseWebservice.h"

typedef enum {
    LocationWebServiceGetLocations = 1,
    LocationWebServiceGetGuestsForLocation = 2,
} LocationWebserviceType;

@interface LocationWebservice : BaseWebservice
- (void)getLocations;
- (void)getGuestsForLocation:(NSString *)locationID;
@end

//
//  BaseWebservice.m
//  
//
//  Created by Chris Martinez on 12/8/13.
//
//

#import "BaseWebservice.h"
#import "CoreNetworkCommunicationResponse.h"

@implementation BaseWebservice

- (instancetype) init {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    CoreNetworkCommunicationSettings * settings = [CoreNetworkCommunicationSettings new];
    settings.url = [NSURL URLWithString: @""];
    settings.showNetworkActivity = YES;
    settings.timeout = 60;
    settings.enableCompression = NO;
    
    return [self initWithSettings:settings];
}

- (instancetype) initWithSettings:(CoreNetworkCommunicationSettings *)settings {
     NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    self = [super init];
    
    if (self) {
        _networkCommunication = [CoreNetworkCommunicationLibrary createNetworkCommunicationObject:settings];
        _networkCommunication.delegate = self;
        
        // read the base URL from the Info PLIST
        NSBundle* mainBundle = [NSBundle mainBundle];
        
        // Reads the value of the custom key I added to the Info.plist
        self.baseURL = [mainBundle objectForInfoDictionaryKey:@"WebserverBaseURL"];
    }
    
    return self;
}

- (void) DELETE {
    
    // set the JSON headers
    CoreNetworkCommunicationSettings *settings = [self.networkCommunication settings];
    NSString *loginString = @"token";
    NSData *encodedLoginData=[loginString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authHeader=[NSString stringWithFormat:@"Basic %@",  [encodedLoginData base64Encoding]];
    NSDictionary *headers = @{@"Content-Type": @"application/json", @"Accept": @"application/json", @"Authorization": authHeader};
    settings.headers = headers;
    
#warning Add reachability to server
    if (YES) {
        [self.networkCommunication DELETE];
    } else {
        // report connection error
        if (self.delegate) {
             NSLog(@"%@", [NSString stringWithFormat:@"No connectivity: %s", __PRETTY_FUNCTION__]);
            NSError * error = [[NSError alloc] initWithDomain:NSArgumentDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"No Connectivity", @"No connectivity")}];
            [self.delegate serviceCallDidFailWithError:self withError:error];
        }
    }
}

- (void) GET {
    // set the JSON headers & add the session token
    CoreNetworkCommunicationSettings *settings = [self.networkCommunication settings];
    NSString *loginString = @"token";
    NSData *encodedLoginData=[loginString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authHeader=[NSString stringWithFormat:@"Basic %@",  loginString];
    NSDictionary *headers = @{@"Content-Type": @"application/json", @"Accept": @"application/json", @"Authorization": authHeader};
    settings.headers = headers;
    
#warning Add reachability to server
    if (YES) {
        [self.networkCommunication GET];
    } else {
        // report connection error
        if (self.delegate) {
             NSLog(@"%@", [NSString stringWithFormat:@"No connectivity: %s", __PRETTY_FUNCTION__]);
            NSError * error = [[NSError alloc] initWithDomain:NSArgumentDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"No Connectivity", @"No connectivity")}];
            [self.delegate serviceCallDidFailWithError:self withError:error];
        }
    }
}

- (void) POST:(NSData *)data {
    
    // set the JSON headers & add the session token
    CoreNetworkCommunicationSettings *settings = [self.networkCommunication settings];
    NSString *loginString = @"token";
    NSData *encodedLoginData=[loginString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authHeader=[NSString stringWithFormat:@"Basic %@",  [encodedLoginData base64Encoding]];
    NSDictionary *headers = @{@"Content-Type": @"application/json", @"Accept": @"application/json", @"Authorization": authHeader};
    settings.headers = headers;
    
#warning Add reachability to server
    if (YES) {
        [self.networkCommunication POST:data];
    } else {
        // report connection error
        if (self.delegate) {
             NSLog(@"%@", [NSString stringWithFormat:@"No connectivity: %s", __PRETTY_FUNCTION__]);
            NSError * error = [[NSError alloc] initWithDomain:NSArgumentDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"No Connectivity", @"No connectivity")}];
            [self.delegate serviceCallDidFailWithError:self withError:error];
        }
    }
}

- (void) PUT:(NSData *)data {
    
    // set the JSON headers & add the session token
    CoreNetworkCommunicationSettings *settings = [self.networkCommunication settings];
    NSString *loginString = @"token";
    NSData *encodedLoginData=[loginString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authHeader=[NSString stringWithFormat:@"Basic %@",  [encodedLoginData base64Encoding]];
    NSDictionary *headers = @{@"Content-Type": @"application/json", @"Accept": @"application/json", @"Authorization": authHeader};
    settings.headers = headers;
    
#warning Add reachability to server
    if (YES) {
        [self.networkCommunication PUT:data];
    } else {
        // report connection error
        if (self.delegate) {
             NSLog(@"%@", [NSString stringWithFormat:@"No connectivity: %s", __PRETTY_FUNCTION__]);
            NSError * error = [[NSError alloc] initWithDomain:NSArgumentDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"No Connectivity", @"No connectivity")}];
            [self.delegate serviceCallDidFailWithError:self withError:error];
        }
    }
}

#pragma mark - CoreNetworkCommunicationDelegate

- (void)networkCallDidFinishLoading:(CoreNetworkCommunicationResponse *)response {
     NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    switch (response.status) {
            // get the JSON Dictionary or Array
        case 200:
        case 204:
            if (response.data && [response.data length]) {
                NSError * error = nil;
                
                id object = [NSJSONSerialization JSONObjectWithData:response.data options:kNilOptions error:&error];
                
                if (error) {
                     NSLog(@"%@", [NSString stringWithFormat:@"VitasWebservice JSON serializaion Failed %@",[error localizedDescription]]);
                } else {
                    // get the dictionary or array from the JSON object
                    if ([object isKindOfClass:[NSDictionary class]]) {
                        self.dictionary = (NSDictionary *)object;
                    } else if ([object isKindOfClass:[NSArray class]]) {
                        self.array = (NSArray *)object;
                    }
                }
            }
            
            if (self.delegate) {
                 NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
                [self.delegate serviceCallDidFinishLoading:self withResponse:response];
            }
            return;
            
            break;
            
        default:
            break;
    }
    
    if (self.delegate) {
         NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:response.message forKey:NSLocalizedDescriptionKey];
        NSError * error = [[NSError alloc] initWithDomain:NSArgumentDomain code:response.status userInfo:dict];
        [self.delegate serviceCallDidFailWithError:self withError:error];
    }
}

- (void)networkCallDidFailWithError:(NSError *)error {
     NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
    
    if (self.delegate) {
        NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
        [self.delegate serviceCallDidFailWithError:self withError:error];
    }
}

- (void)networkCallDidReceiveData:(NSData *)data {
    // no implementation required
     NSLog(@"%@", [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]);
}

@end

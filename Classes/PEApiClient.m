//
//  PApiClient.m
//  saeapns
//
//  Created by Eric X.u on 08/06/2013.
//
//

#import "PEApiClient.h"
//#import "AFNetworking.h"
//#import "TFResponse.h"
//#import "TFApiParser.h"

#define HTTP_DIGEST_USER             @"idea4u"
#define HTTP_DIGEST_PASS             @"idea4uWQTec890"

@implementation PEApiClient

+ (PEApiClient *)sharePApiClient
{
    static PEApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[PEApiClient alloc] initWithBaseURL:
                            [NSURL URLWithString:PENDORA_API_BASE]
                            ];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super alloc];
    if (!self) {
        return nil;
    }  
   
    return self;
}

@end

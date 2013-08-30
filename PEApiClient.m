//
//  PApiClient.m
//  saeapns
//
//  Created by Eric X.u on 08/06/2013.
//
//

#import "PEApiClient.h"
#import "AFNetworking.h"
#import "TFResponse.h"
#import "TFApiParser.h"

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
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultCredential:[NSURLCredential credentialWithUser:HTTP_DIGEST_USER
                                                          password:HTTP_DIGEST_PASS
                                                       persistence:NSURLCredentialPersistenceForSession]];
    
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
    NSString *version = (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    
    [self setDefaultHeader:@"User-Agent" value:[NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)",
                                                name,
                                                version,
                                                [[UIDevice currentDevice] model],
                                                [[UIDevice currentDevice] systemVersion],
                                                ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0f)]];
    
    return self;
}


#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)requestForGet:(NSDictionary *)params
                 path:(NSString *)path
               target:(id)target
             selector:(SEL)selector
        parseSelector:(SEL)parseSelector
{
    TFResponse *response = [[TFResponse alloc] init];
    [self getPath:path
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"status"] intValue] == 1) {
                  response.status = 1;
                  response.data = [[TFApiParser sharedParser] performSelector:parseSelector
                                                                   withObject:[responseObject objectForKey:@"data"]];
              }else{
                  response.status = [[responseObject objectForKey:@"status"] intValue];
                  response.msg = [responseObject objectForKey:@"msg"];
              }
              [target performSelector:selector withObject:response];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              response.status = error.code;
              response.msg = [error localizedDescription];
              [target performSelector:selector withObject:response];
          }];
}


- (NSInteger)loginWithIdentity:(NSString *)identity password:(NSString *)passwd
{
    
}

@end

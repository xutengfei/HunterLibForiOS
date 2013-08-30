//
//  PApiClient.h
//  saeapns
//
//  Created by Eric X.u on 08/06/2013.
//
//

#import <Foundation/Foundation.h>
//#import "AFNetworking.h"
//#import "TFApiUrls.h"

@interface PEApiClient // : AFHTTPClient

+ (PEApiClient *)sharePApiClient;

- (NSInteger)loginWithIdentity:(NSString *)identity password:(NSString *)passwd;
@end

//
//  Loader.h
//  Homework_5
//
//  Created by Рамазан Даминов on 14.03.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Loader : NSObject

@property (nonatomic, strong) NSURLSession *session;

- (void) performGetRequestForUrl: (NSString*) stringUrl
    arguments: (NSDictionary*) arguments
    completion: (void (^) (NSDictionary*, NSError*)) completion;

- (void) performPostRequestForUrl: (NSString*) stringUrl
    arguments: (NSDictionary*) arguments
    completion: (void (^) (NSDictionary*, NSError*)) completion;

- (NSDictionary*) parseJSONData: (NSData*) data error: (NSError**) error;

- (NSData*) dataWithJSON: (NSDictionary*) dict error: (NSError**) error;

@end

NS_ASSUME_NONNULL_END

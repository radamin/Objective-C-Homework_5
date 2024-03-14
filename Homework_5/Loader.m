//
//  Loader.m
//  Homework_5
//
//  Created by Рамазан Даминов on 14.03.2024.
//

#import "Loader.h"

@implementation Loader

-(NSURLSession *) session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPAdditionalHeaders = @{
            @"Content-Type":@"Application/JSON",
            @"User-Agent":@"iPhone 15ProMax Simulator"
        };
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

- (void) performGetRequestForUrl: (NSString*) stringUrl
    arguments: (NSDictionary*) arguments
    completion: (void (^) (NSDictionary*, NSError*)) completion {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:stringUrl];
    if (arguments) {
        NSMutableArray<NSURLQueryItem*>* queryItems = [NSMutableArray new];
        for (NSString *key in arguments.allKeys) {
            [queryItems addObject: [NSURLQueryItem queryItemWithName:key value:arguments[key]]];
        }
        urlComponents.queryItems = [queryItems copy];
    }
    NSURL *url = urlComponents.URL;
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;;
        }
        NSError *parsingError;
        NSDictionary *dictionary = [self parseJSONData:data error:&parsingError];
        if (parsingError) {
            completion(nil, parsingError);
            return;;
        }
        completion(dictionary, nil);
    }];
    [dataTask resume];
}

- (void) performPostRequestForUrl: (NSString*) stringUrl
    arguments: (NSDictionary*) arguments
    completion: (void (^) (NSDictionary*, NSError*)) completion {
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    if (arguments) {
        NSData *data = [self dataWithJSON:arguments error:nil];
        request.HTTPBody = data;
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                completion(nil, error);
                return;;
            }
            NSError *parsingError;
            NSDictionary *dictionary = [self parseJSONData:data error:&parsingError];
            if (parsingError) {
                completion(nil, parsingError);
                return;;
            }
            completion(dictionary, nil);
        }];
        [dataTask resume];
    }
}

- (NSDictionary*) parseJSONData: (NSData*) data error: (NSError**) error {
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
}

- (NSData*) dataWithJSON: (NSDictionary*) dict error: (NSError**) error {
    return [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
}

@end

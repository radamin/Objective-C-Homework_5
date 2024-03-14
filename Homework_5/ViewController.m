//
//  ViewController.m
//  Homework_5
//
//  Created by Рамазан Даминов on 14.03.2024.
//

#import "ViewController.h"
#import "Loader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loader = [Loader new];
    [self performLoadingWithGetRequest];
}

- (void) performLoadingWithGetRequest {
    [self.loader performGetRequestForUrl:@"https://postman-echo.com/get?" arguments:@{@"key1":@"val1", @"key2":@"val2"} completion:^(NSDictionary *dict, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"%@", error);
                return;
            }
            NSLog(@"%@", dict);
        });
    }];
}

- (void) performLoadingWithPostRequest {
    [self.loader performPostRequestForUrl:@"https://postman-echo.com/post?" arguments:@{@"key1":@"val1", @"key2":@"val2"} completion:^(NSDictionary *dict, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"%@", error);
                return;
            }
            NSLog(@"%@", dict);
        });
    }];
}


@end

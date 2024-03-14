//
//  PostViewController.m
//  Homework_5
//
//  Created by Рамазан Даминов on 14.03.2024.
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"POST";
    
    [self setupViews];
    
    self.loader = [Loader new];
}

- (void) setupViews {
    self.textField1 = [UITextField new];
    self.textField1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField1];
    self.textField1.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.textField2 = [UITextField new];
    self.textField2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField2];
    self.textField2.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.postDataButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.postDataButton setBackgroundColor:[UIColor blueColor]];
    [self.postDataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.postDataButton setTitle:@"Post Data" forState:UIControlStateNormal];
    [self.view addSubview:self.postDataButton];
    self.postDataButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.postDataButton addTarget:self action:@selector(postDataButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.postDataButton];
        
    [NSLayoutConstraint activateConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.textField1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.textField2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.postDataButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.textField1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:200],
        [NSLayoutConstraint constraintWithItem:self.textField2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.textField1 attribute:NSLayoutAttributeBottom multiplier:1 constant:50],
        [NSLayoutConstraint constraintWithItem:self.postDataButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.textField2 attribute:NSLayoutAttributeBottom multiplier:1 constant:50],
        [NSLayoutConstraint constraintWithItem:self.textField1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.7 constant:0],
        [NSLayoutConstraint constraintWithItem:self.textField2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.7 constant:0],
        [NSLayoutConstraint constraintWithItem:self.postDataButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0]
    ]];
}

- (void)postDataButtonTapped:(id)sender {
    [self performLoadingWithPostRequest];
}

- (void) performLoadingWithPostRequest {
    [self.loader performPostRequestForUrl:@"https://postman-echo.com/post?" arguments:@{@"key1":self.textField1.text, @"key2":self.textField2.text} completion:^(NSDictionary *dict, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"%@", error);
                return;
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Data sent successfully" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

@end

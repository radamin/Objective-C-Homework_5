//
//  GetViewController.h
//  Homework_5
//
//  Created by Рамазан Даминов on 14.03.2024.
//

#import <UIKit/UIKit.h>
#import "Loader.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetViewController : UIViewController

@property (nonatomic, strong) Loader *loader;
@property (nonatomic, strong) UITextView *textView;

@end

NS_ASSUME_NONNULL_END

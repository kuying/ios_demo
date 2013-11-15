//
//  HelloWorldViewController.h
//  HelloWorld
//
//  Created by 库颖 on 13-11-15.
//  Copyright (c) 2013年 库颖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloWorldViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UILabel *lblHelloWorld;
- (IBAction)doBtnHello:(id)sender;
- (IBAction)doBtnHide:(id)sender;

@end

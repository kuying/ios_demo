//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by 库颖 on 13-11-15.
//  Copyright (c) 2013年 库颖. All rights reserved.
//

#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()

@end

@implementation HelloWorldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doBtnHello:(id)sender {
    NSString *name = self.txtName.text;
    
    if ([name length] == 0) {
        name = NSLocalizedString(@"WORLD", @"world localizable");
    }
    
    self.lblHelloWorld.text = [[NSString alloc] initWithFormat:NSLocalizedString(@"HELLO", @"hello localizable"), name];
}

- (IBAction)doBtnHide:(id)sender {
    [self.lblHelloWorld setHidden:![self.lblHelloWorld isHidden]];
    [sender setTitle:[self.lblHelloWorld isHidden]? NSLocalizedString(@"SHOW", @"show localizable") : NSLocalizedString(@"HIDE", @"hide localizable") forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.txtName) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

@end

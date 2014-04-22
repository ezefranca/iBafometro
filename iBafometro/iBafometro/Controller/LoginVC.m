//
//  FirstViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "LoginVC.h"
#import "OnibusVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBarController.tabBar setHidden:NO];
    	// Do any additional setup after loading the view, typically from a nib.
    //[[self tabBar] setSelectedImageTintColor:[UIColor greenColor]];
   // CGRect x = self.facebuquis.bounds;
    
    //Facebook
    
    FBLoginView *loginview = [[FBLoginView alloc] init];
    loginview.frame = CGRectOffset(loginview.frame, 50, 350);
    loginview.delegate = self;
    [loginview sizeToFit];
    loginview.readPermissions = @[@"basic_info", @"email", @"user_likes"];
    [self.view addSubview:loginview];
    
//    self.facebuquis.layer.cornerRadius = 5;
//    self.facebuquis.layer.borderWidth = 1.0f;
//    self.facebuquis.layer.borderColor = [UIColor clearColor].CGColor;
//    self.facebuquis.clipsToBounds = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)longPressDetected:(UILongPressGestureRecognizer *)sender{
    
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {

 }


@end

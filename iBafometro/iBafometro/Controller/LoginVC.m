//
//  FirstViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "LoginVC.h"
#import "OnibusVC.h"
#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]

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
//    loginview.frame = CGRectOffset(loginview.frame, 50, 350);
//    loginview.delegate = self;
//    [loginview sizeToFit];
//    loginview.readPermissions = @[@"basic_info", @"email", @"user_likes"];
//    loginview.backgroundColor = RGB(0, 0, 0);

    loginview.frame = CGRectOffset(loginview.frame, 50, 350);
    for (id obj in loginview.subviews)
    {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton * loginButton =  obj;
            UIImage *loginImage = [UIImage imageNamed:@"facebook-login.png"];
            [loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
            [loginButton setBackgroundImage:nil forState:UIControlStateSelected];
            [loginButton setBackgroundImage:nil forState:UIControlStateHighlighted];
            [loginButton sizeToFit];
        }
//        if ([obj isKindOfClass:[UILabel class]])
//        {
//            UILabel * loginLabel =  obj;
//            loginLabel.text = @"Log in to facebook";
//           // loginLabel.textAlignment = UITextAlignmentCenter;
//            loginLabel.frame = CGRectMake(0, 0, 271, 37);
//        }
    }
    
    loginview.delegate = self;
    
    
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

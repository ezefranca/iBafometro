//
//  SocialViewController.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SocialViewController : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBProfilePictureView *picture;
@property (weak, nonatomic) IBOutlet UILabel *name;


@property (weak, nonatomic) IBOutlet UIButton *list;
@property (weak, nonatomic) IBOutlet UIButton *user_info;
@property (weak, nonatomic) IBOutlet UIButton *friends_info;


@property (weak, nonatomic) IBOutlet UIButton *shareLinkWithShareDialog;
@property (weak, nonatomic) IBOutlet UIButton *postStatusUpdateWithShareDialog;


@property (weak, nonatomic) IBOutlet UIButton *ShareLinkWithAPICalls;
@property (weak, nonatomic) IBOutlet UIButton *StatusUpdateWithAPICalls;
- (IBAction)list:(id)sender;


@end

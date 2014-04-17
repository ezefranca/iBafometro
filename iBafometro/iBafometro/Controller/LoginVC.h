//
//  FirstViewController.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginVC : UIViewController <FBLoginViewDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *facebuquis;

@end

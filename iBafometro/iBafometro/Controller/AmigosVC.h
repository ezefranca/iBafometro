//
//  AmigosView.h
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//
#import "OnibusVC.h"
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AmigosVC : UIViewController <FBLoginViewDelegate, FUIAlertViewDelegate>
- (IBAction)botaoAmigo:(id)sender;
- (IBAction)apagarBotao:(id)sender;

@end

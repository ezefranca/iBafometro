//
//  AmigosView.h
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AmigosVC : UIViewController <FBLoginViewDelegate>
- (IBAction)botaoAmigo:(id)sender;
- (IBAction)apagarBotao:(id)sender;

@end

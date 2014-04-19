//
//  SettingsViewController.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

#import "UIColor+FlatUI.h"
#import "UISlider+FlatUI.h"
#import "UIStepper+FlatUI.h"
#import "UITabBar+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "FUIButton.h"
#import "FUISwitch.h"
#import "UIFont+FlatUI.h"
#import "FUIAlertView.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIProgressView+FlatUI.h"
#import "FUISegmentedControl.h"
#import "UIPopoverController+FlatUI.h"

@interface SettingsVC : UIViewController <UIApplicationDelegate, FBLoginViewDelegate, FBViewControllerDelegate, FUIAlertViewDelegate>
- (IBAction)botaoSalvar:(id)sender;
- (IBAction)botaoConsulta:(id)sender;
- (IBAction)botaoAmigo:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *labelNome;
@property (weak, nonatomic) IBOutlet UITextField *labelTaxista;
@property (weak, nonatomic) IBOutlet UITextField *labelAmigo;
@property (weak, nonatomic) IBOutlet UITextField *labelEndereco;

@property FUIAlertView *alertView;

@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;

@end

//
//  SecondViewController.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "CharReceiver.h"
#import "PNChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "AudioSignalAnalyzer.h"
#import "FSKSerialGenerator.h"
#import "FSKRecognizer.h"
#import "CharReceiver.h"
#import "MSAnnotatedGauge.h"

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


@interface BafometroVC : UIViewController <AVAudioSessionDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate, FUIAlertViewDelegate, UIAlertViewDelegate, CharReceiver>
- (IBAction)apagar:(id)sender;
- (IBAction)buttonBafometer:(id)sender;

@property (weak, nonatomic) IBOutlet FUIButton *alertViewButton;
@property (nonatomic) MSAnnotatedGauge *annotatedGauge;
@property (nonatomic) NSArray *gauges;
@property NSTimer* timer;
@end

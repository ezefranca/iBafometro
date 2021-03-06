//
//  AppDelegate.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVFoundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SocialVC.h"
#import "BafometroVC.h"
#import "FSKSerialGenerator.h"
#define APP_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])


@interface AppDelegate : UIResponder <UIApplicationDelegate, AVAudioSessionDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, MKMapViewDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate> {

//@public
    //FSKSerialGenerator* _generator;
}
//@property (strong, nonatomic) BafometroVC *bafometroView;
//@property (strong, nonatomic) FSKRecognizer *recognizer;
//@property (strong, nonatomic) AudioSignalAnalyzer *analyzer;
//@property (strong, nonatomic) FSKSerialGenerator *generator;
@property NSError *erro;

@property (strong, nonatomic) UIWindow *window;

@end


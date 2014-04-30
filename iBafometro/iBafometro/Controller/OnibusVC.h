//
//  OnibusView.h
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

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

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PontosOnibus.h"
#import "APIOlhoVivo.h"
#import "MapaVC.h"

@interface OnibusVC : UIViewController <MKMapViewDelegate, MKAnnotation, CLLocationManagerDelegate, FUIAlertViewDelegate>
{
    NSData *jsonDados;
    APIOlhoVivo *olhoVivo;
}
- (IBAction)ligarOnibus2:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapa;

-(void)desenhaPontos;

@property double latitude;
@property double longitude;

@property NSTimer* timer;

@property (strong, nonatomic) IBOutlet UIView *detalhes;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;
- (IBAction)fechaDetalhes:(id)sender;



@end

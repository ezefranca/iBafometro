//
//  TaxiView.h
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PontosTaxi.h"
#import "MapaVC.h"

@interface TaxiVC : UIViewController <MKMapViewDelegate, MKAnnotation, CLLocationManagerDelegate>
{
    NSData *jsonDados;
    double latitude;
    double longitude;
}
- (IBAction)ligarTaxi1:(id)sender;
- (IBAction)ligarTaxi2:(id)sender;

-(void)desenhaPontos;

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@end

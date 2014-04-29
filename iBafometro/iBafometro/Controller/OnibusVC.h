//
//  OnibusView.h
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
#import "PontosOnibus.h"
#import "APIOlhoVivo.h"
#import "MapaVC.h"

@interface OnibusVC : UIViewController <MKMapViewDelegate, MKAnnotation, CLLocationManagerDelegate>
{
    NSData *jsonDados;
    double latitude;
    double longitude;
    APIOlhoVivo *olhoVivo;
}
- (IBAction)ligarOnibus1:(id)sender;
- (IBAction)ligarOnibus2:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapa;

-(void)desenhaPontos;

@property (strong, nonatomic) IBOutlet UIView *detalhes;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;
- (IBAction)fechaDetalhes:(id)sender;



@end

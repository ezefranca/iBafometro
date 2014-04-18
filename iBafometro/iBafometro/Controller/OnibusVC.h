//
//  OnibusViewController.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface OnibusVC : UIViewController <MKMapViewDelegate, MKAnnotation>

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (weak, nonatomic) IBOutlet UIButton *localizarUsuario;

- (IBAction)botaoPosicao:(id)sender;

@end

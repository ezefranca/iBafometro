//
//  MapaViewController.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapaVC : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate>
{
    CLLocationManager *localizacaoManager;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) IBOutlet UIView *vidro;

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) UIColor *cor;

@end

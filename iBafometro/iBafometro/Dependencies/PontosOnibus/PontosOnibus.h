//
//  PontosOnibus.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 18/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PontosOnibus : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitulo;
@property int tag;

- (id)initWithTitle:(NSString *)Titulo Localizacao:(CLLocationCoordinate2D)aCordenada;
- (MKAnnotationView*) pontoDeOnibusView;
@end

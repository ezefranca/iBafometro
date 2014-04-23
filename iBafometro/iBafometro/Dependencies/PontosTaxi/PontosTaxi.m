//
//  PontosTaxi.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 18/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "PontosTaxi.h"

@implementation PontosTaxi

//@synthesize coordinate;
//@synthesize title;
//@synthesize subtitulo;
//@synthesize tag;

- (id)initWithTitle:(NSString *)Titulo Localizacao:(CLLocationCoordinate2D)aCordenada
{
    self = [super init];
    if (self) {
        _coordinate = aCordenada;
        _title = Titulo;
    }
    return self;
}

-(MKAnnotationView *)pontoDeTaxiView{
    MKAnnotationView *ponto_taxi = [[MKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"PontosOnibus"];
    
    ponto_taxi.enabled = YES;
    ponto_taxi.canShowCallout = YES;
    ponto_taxi.image = [UIImage imageNamed:@"taxi.png"];
    ponto_taxi.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return ponto_taxi;
    
}

@end
//
//  PontosOnibus.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 18/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "PontosOnibus.h"

@implementation PontosOnibus

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

-(MKAnnotationView *)pontoDeOnibusView{
    MKAnnotationView *ponto_onibus = [[MKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"PontosOnibus"];
    
    ponto_onibus.enabled = YES;
    ponto_onibus.canShowCallout = YES;
    ponto_onibus.image = [UIImage imageNamed:@"busstop.png"];
    ponto_onibus.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return ponto_onibus;
    
}

@end

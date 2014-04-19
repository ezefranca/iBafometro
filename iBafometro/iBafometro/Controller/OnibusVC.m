//
//  OnibusViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "OnibusVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PontosOnibus.h"

@implementation OnibusVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapa.delegate = self;
    [self.mapa setShowsUserLocation:YES];
    CLLocationCoordinate2D annotationCoordinate = CLLocationCoordinate2DMake(28.544192, -81.373286);
    
    PontosOnibus *ponto_onibus = [[PontosOnibus alloc]initWithTitle:@"Ponto de Onibus" Localizacao:annotationCoordinate];

 //   ponto_onibus.subtitle = @"Cool swans";
 //   ponto_onibus.image = [UIImage imageNamed:@"bus25.png"];
    
    [self.mapa addAnnotation:ponto_onibus];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)botaoPosicao:(id)sender {
    MKCoordinateRegion region;

    region.center = self.mapa.userLocation.coordinate;
    
    [self.mapa setRegion:region animated:YES];
    [self.mapa setShowsUserLocation:YES];
    //NSLog(@"%@", _teste);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D usuario = userLocation.location.coordinate;
    MKCoordinateRegion centroDoMapa = MKCoordinateRegionMakeWithDistance(usuario, 1000, 1000);
   
    [self.mapa setRegion:centroDoMapa];
}

- (MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[PontosOnibus class]]) {
 
        PontosOnibus *ponto = (PontosOnibus *)annotation;
        MKAnnotationView *anotacao = [self.mapa dequeueReusableAnnotationViewWithIdentifier:@"PontosOnibus"];

    if(anotacao == nil) {
        anotacao = ponto.pontoDeOnibusView;
    }else{
        anotacao.annotation = annotation;
    }
    
    return anotacao;
    }
    return nil;
}

@end

//
//  MapaViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MapaView.h"

@interface MapaView ()

@end

@implementation MapaView

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
    
    [self.mapa setDelegate:self];
    
   
    
    
    //Deixar o mapa redondo
    CGRect x = self.mapa.bounds;
    self.mapa.layer.cornerRadius = CGRectGetHeight(x) / 2;
    self.mapa.layer.borderWidth = 1.0f;
    self.mapa.layer.borderColor = [UIColor clearColor].CGColor;
    self.mapa.clipsToBounds = YES;
    
    self.vidro.layer.cornerRadius = CGRectGetHeight(x) / 2;
    self.vidro.layer.borderWidth = 1.0f;
    self.vidro.layer.borderColor = [UIColor clearColor].CGColor;
    self.vidro.clipsToBounds = YES;
    //-----------------------------
    
    //Desenhar o Radar
    
    CGRect rectangle = CGRectMake(0,0,100,100);
    self.mapa.layer.frame = rectangle;

    
    
    //-----------------------------
    
    
    //Instantiate a location object.
    localizacaoManager = [[CLLocationManager alloc] init];
    
    //Make this controller the delegate for the location manager.
    [localizacaoManager setDelegate:self];
    
    //Set some parameters for the location object.
    [localizacaoManager setDistanceFilter:kCLDistanceFilterNone];
    [localizacaoManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    
     [self.mapa setShowsUserLocation:YES];
    
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

#pragma mark - MKMapViewDelegate methods.
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    MKCoordinateRegion region;
    region = MKCoordinateRegionMakeWithDistance(localizacaoManager.location.coordinate,1000,1000);
    
    
    [mv setRegion:region animated:YES];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor colorWithRed:204/255. green:45/255. blue:70/255. alpha:1.0];
    polylineView.lineWidth = 10.0;
    
    return polylineView;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.mapa.centerCoordinate = userLocation.location.coordinate;
}

@end

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

@interface OnibusVC ()

@end

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
    // Do any additional setup after loading the view.
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
   _teste = userLocation.location.coordinate;
    
    self.mapa.centerCoordinate = userLocation.location.coordinate;
}

@end

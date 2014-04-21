//
//  MapaViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MapaVC.h"
#import "OnibusVC.h"

@interface MapaVC ()

@end

@implementation MapaVC

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
    //Desabilitar gestos automaticos
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    //Configuraçao do Mapa
    [self.mapa setDelegate:self];
    
//    NSDictionary *mapLocation = @{@"name": @"Walt Disney World",
//                                  @"lat": @28.41871,
//                                  @"lng": @-81.58121
//                                  };
//    double latitude = [[mapLocation objectForKey:@"lat"] floatValue];
//    double longitude = [[mapLocation objectForKey:@"lng"] floatValue];
//    
//	CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
//    //NSLog(@"lat: %f, lng: %f", coordinate.latitude, coordinate.longitude);

    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"mapaOnibus"]) {
    }
}


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

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [self showTabBar];
}

- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:1
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
    
    // 1
}

- (void)showTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
                         tabBar.frame = tabFrame;
                         
                         CGRect contentFrame = content.frame;
                         contentFrame.size.height -= tabFrame.size.height;
                     }];
    
    // 2
    
    
}
@end


//
//  TaxiView.m
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "TaxiVC.h"

@interface TaxiVC ()

@end

@implementation TaxiVC{
CLLocationManager *locationManager;
}

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
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
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

- (void)googlePlaces: (NSString *)stringforPlace{
    
    jsonDados = [[NSData alloc] initWithContentsOfURL:
                 [NSURL URLWithString:stringforPlace]];
    
    NSError *error;
    NSMutableDictionary *jsonDadosUsuario = [NSJSONSerialization
                                             JSONObjectWithData:jsonDados
                                             options:NSJSONReadingMutableContainers
                                             error:&error];
    
    NSLog(@"%@", jsonDadosUsuario);
    
    //    for (NSString *string in myArray)
    //    {
    //        // do stuff...
    //    }
    
    
    for (int i = 0; i < [[jsonDadosUsuario objectForKey:@"results"] count]; i++)
    {
        double Latitude = [[[[[[jsonDadosUsuario objectForKey:@"results"] objectAtIndex:i] objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lat"] floatValue];
        double Longitude = [[[[[[jsonDadosUsuario objectForKey:@"results"] objectAtIndex:i] objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lng"] floatValue];
        
        CLLocationCoordinate2D Coordenada_ponto_de_taxi = CLLocationCoordinate2DMake(Latitude, Longitude);
        
        PontosTaxi *ponto_taxi = [[PontosTaxi alloc]initWithTitle:@"Ponto de Taxi" Localizacao:Coordenada_ponto_de_taxi];
        [self.mapa addAnnotation:ponto_taxi];
        //NSLog(@"%f, %f", Latitude, Longitude );
    }
    
    
}

#pragma mark - CLLocationManagerDelegate

//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    //NSLog(@"didFailWithError: %@", error);
//    UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [errorAlert show];
//}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   // NSLog(@"Localizacao: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        longitude = currentLocation.coordinate.longitude;
        latitude  = currentLocation.coordinate.latitude;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"voltou");
    [super viewWillDisappear:YES];
    
    //    if ([self.delegate respondsToSelector:@selector(finishedReading:)]) {
    //        [self.delegate finishedReadingWithPosition:self.position];
    //    }
}


- (void)desenhaPontos{
    MKCoordinateRegion region;
    region.center = self.mapa.userLocation.coordinate;
    
    NSString *urlString =
    [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=5000&sensor=false&types=taxi_stand&key=AIzaSyBG-qHUWnj375cRL4ke_Fe4-c_lxQIJrPI", latitude, longitude];
    [self googlePlaces:urlString];
    //NSLog(@"%@", _teste);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D usuario = userLocation.location.coordinate;
    MKCoordinateRegion centroDoMapa = MKCoordinateRegionMakeWithDistance(usuario, 500, 500);
    
    [self.mapa setRegion:centroDoMapa];
}

- (MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[PontosTaxi class]]) {
        
        PontosTaxi *ponto = (PontosTaxi *)annotation;
        MKAnnotationView *anotacao = [self.mapa dequeueReusableAnnotationViewWithIdentifier:@"PontosTaxi"];
        
        if(anotacao == nil) {
            anotacao = ponto.pontoDeTaxiView;
        }else{
            anotacao.annotation = annotation;
        }
        
        return anotacao;
    }
    return nil;
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

- (IBAction)ligarTaxi1:(id)sender {
    NSLog(@"%f  %f", latitude, longitude);
    [self desenhaPontos];
    [self ligandoTaxista];
}

- (IBAction)ligarTaxi2:(id)sender {
    [self desenhaPontos];
    [self ligandoTaxista];
}


- (void)ligandoTaxista{
    NSString *numeroTaxista = @"+919876543210";
    NSURL *telefoneURL = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",numeroTaxista]];
    
    if ([[UIApplication sharedApplication] canOpenURL:telefoneURL]) {
        [[UIApplication sharedApplication] openURL:telefoneURL];
    } else
    {
        NSLog(@"Nao foi possivel fazer sua ligacao");
    }
}

#pragma mark Ligaçāo Taxista

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [self hideTabBar];
}

- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
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

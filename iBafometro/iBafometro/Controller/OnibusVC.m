//
//  OnibusView.m
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "OnibusVC.h"
#import "APIOlhoVivo.h"
#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]

@interface OnibusVC ()

@end

@implementation OnibusVC{
    CLLocationManager *locationManager;
    NSMutableArray *resultados;
}
@synthesize mapa;
@synthesize timer;
@synthesize detalhes;
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;

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
    
    olhoVivo = [[APIOlhoVivo alloc]initWithToken:@"67542d68a9ba2751de039bd09dd42473e1d6e51cbdc49ebfec2bc4d52fc32102"];
    
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
    
    NSArray *keys = [jsonDadosUsuario allKeys];
    id aKey = [keys objectAtIndex:1];
    //NSString *status = [jsonDadosUsuario objectForKey:aKey];
    
    aKey = [keys objectAtIndex:0];
    NSString *rua = [[[jsonDadosUsuario objectForKey:aKey]objectAtIndex:0]objectForKey:@"formatted_address"];
    
    NSArray *nomedaRuaSeparado = [rua componentsSeparatedByString:@" "];
    NSString *buscarRua = [nomedaRuaSeparado objectAtIndex:3]; //word3
    
    //NSLog(@"%@\n %@", buscarRua, rua);
    

    resultados = [olhoVivo busca:buscarRua comOtermo:@"Parada"];
    NSLog(@"%@", resultados);
    //    for (NSString *string in myArray)
    //    {
    //        // do stuff...
    //    }
    
    float Latitude = [[[resultados objectAtIndex:0]objectForKey:@"Latitude"]floatValue];
    NSLog(@"--------%f", Latitude);
    
    for (int i = 0; i < [resultados count]; i++)
    {
        
        float Latitude = [[[resultados objectAtIndex:i]objectForKey:@"Latitude"]floatValue];
        float Longitude = [[[resultados objectAtIndex:i]objectForKey:@"Longitude"]floatValue];
//        double Latitude = [[[[[[jsonDadosUsuario objectForKey:@"results"] objectAtIndex:i] objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lat"] floatValue];
//        double Longitude = [[[[[[jsonDadosUsuario objectForKey:@"results"] objectAtIndex:i] objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lng"] floatValue];
        
        NSString *Endereco = [[resultados objectAtIndex:i]objectForKey:@"Endereco"];
        NSLog(@"RUA XXX %@", Endereco);
        
        
        CLLocationCoordinate2D Coordenada_ponto_de_onibus = CLLocationCoordinate2DMake(Latitude, Longitude);
        
        PontosOnibus *ponto_onibus = [[PontosOnibus alloc]initWithTitle:Endereco Localizacao:Coordenada_ponto_de_onibus];
        ponto_onibus.title = @"Ver Detalhes";
        ponto_onibus.tag = i;
        [self.mapa addAnnotation:ponto_onibus];
        NSLog(@"%f, %f", Latitude, Longitude );
    }
    
#pragma mark - Mata a Thread
    
    [self.timer invalidate];
    self.timer = nil;
    
    
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
        _longitude = currentLocation.coordinate.longitude;
        _latitude  = currentLocation.coordinate.latitude;
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
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false",_latitude, _longitude];
    //NSString *urlString = [NSString stringWithFormat:@"http://www.cruzalinhas.com/linhasquepassam.json?lat=%f&lng=%f", latitude, longitude];
    
    
    //[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=5000&sensor=false&types=bus_station&key=AIzaSyBG-qHUWnj375cRL4ke_Fe4-c_lxQIJrPI", latitude, longitude];
    
    
    NSLog(@"%@", urlString);
   // &rankby=distance&types=bus&name=harbour&sensor=false&key
    [self googlePlaces:urlString];
    //NSLog(@"%@", _teste);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D usuario = userLocation.location.coordinate;
    MKCoordinateRegion centroDoMapa = MKCoordinateRegionMakeWithDistance(usuario, 2000, 2000);
    NSLog(@"centralizando");
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control

{
    
    // here we illustrate how to detect which annotation type was clicked on for its callout
    
    id <MKAnnotation> annotation = [view annotation];
    
    if ([annotation isKindOfClass:[PontosOnibus class]])
        
    {
        CGRect x = self.detalhes.bounds;
        self.detalhes.layer.cornerRadius = CGRectGetHeight(x) / 5;
        self.detalhes.layer.borderWidth = 1.0f;
        self.detalhes.layer.borderColor = [UIColor clearColor].CGColor;
        self.detalhes.clipsToBounds = YES;
        
        PontosOnibus *new = annotation;
        NSString *Endereco = [[resultados objectAtIndex:new.tag]objectForKey:@"Endereco"];
        NSString *CodigoParada = [[resultados objectAtIndex:new.tag]objectForKey:@"CodigoParada"];
        NSString *Nome = [[resultados objectAtIndex:new.tag]objectForKey:@"Nome"];
        NSLog(@"RUA CLICADA %@", Endereco);
        
        self.label1.text = [NSString stringWithFormat:@"Código da Parada: %@", CodigoParada];
        self.label2.text = Nome;
        self.label3.text = Endereco;
        self.detalhes.alpha = 1;
        [[self view]addSubview:self.detalhes];
        NSLog(@"clicked Golden Gate Bridge annotation");
        
//        CodigoParada = 700016618;
//        Endereco = "R JAVAES/ R SERGIO TOMAS";
//        Latitude = "-23.523692";
//        Longitude = "-46.650278";
//        Nome = "SERGIO TOMAS B/C";
        
    }
    
    
    
   // [self.navigationController pushViewController:self.d animated:YES];
    
}

- (IBAction)ligarOnibus2:(id)sender {
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Carregando Pontos..." message:@"Clique no icone do ponto para mais detalhes..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alertView.delegate = self;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = RGB(51, 99, 172);
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(desenhaPontos) userInfo:nil repeats:YES];
    
}

#pragma mark Ligaçāo Onibussta

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
- (IBAction)fechaDetalhes:(id)sender {
    self.detalhes.alpha = 0;
    //[self.detalhes removeFromSuperview];
}
@end

//
//  SecondViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//


#import "BafometroVC.h"
#import "Bafometro.h"
#import "FSKSerialGenerator.h"
#import "PNChart.h"
#import "MyScene.h"
#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]

@interface BafometroVC () {
    UIPopoverController *_popoverController;
}
@end

@interface NSString (NSStringHexToBytes)
-(NSData*) hexToBytes ;
@end

@implementation NSString (NSStringHexToBytes)
-(NSData*) hexToBytes {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
@end



@interface BafometroVC ()

@end

@implementation BafometroVC


- (void)viewDidLoad
{
    
            

    [super viewDidLoad];
    
    self.alertViewButton.buttonColor = [UIColor cloudsColor];
    self.alertViewButton.shadowColor = [UIColor asbestosColor];
    self.alertViewButton.shadowHeight = 3.0f;
    self.alertViewButton.cornerRadius = 6.0f;
    self.alertViewButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [self.alertViewButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
    [self.alertViewButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateHighlighted];

    
    
    self.annotatedGauge = [[MSAnnotatedGauge alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
    self.annotatedGauge.minValue = 0;
    self.annotatedGauge.maxValue = 100;
    self.annotatedGauge.titleLabel.text = @"Bafometris";
    self.annotatedGauge.titleLabel.textColor = RGB(255, 255, 255);
    self.annotatedGauge.startRangeLabel.text = @"0";
    self.annotatedGauge.startRangeLabel.textColor = RGB(255, 255, 255);
    self.annotatedGauge.endRangeLabel.text = @"100";
    self.annotatedGauge.endRangeLabel.textColor = RGB(255, 255, 255);
    //self.annotatedGauge.fillArcFillColor = [UIColor colorWithRed:.41 green:.76 blue:.73 alpha:1];
    //self.annotatedGauge.fillArcStrokeColor = [UIColor colorWithRed:.41 green:.76 blue:.73 alpha:1];
    self.annotatedGauge.value = 30;
    self.annotatedGauge.backgroundColor = RGB(51, 99, 172);
    [self.view addSubview:self.annotatedGauge];
    
    self.gauges = @[self.annotatedGauge];

    
//	PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 100.0, SCREEN_WIDTH, 100.0) andTotal:[NSNumber numberWithInt:100] andCurrent:[NSNumber numberWithInt:33] andClockwise:YES];
//    circleChart.backgroundColor = [UIColor clearColor];
//    [circleChart setStrokeColor:PNRed];
//    [circleChart strokeChart];
    
// 
//    APP_DELEGATE.recognizer = [[FSKRecognizer alloc] init];
//    //APP_DELEGATE.analyzer = [[AudioSignalAnalyzer alloc] init];
//    [APP_DELEGATE.analyzer addRecognizer: APP_DELEGATE.recognizer]; // set recognizer to analyzer
//    [APP_DELEGATE.analyzer record]; // start analyzing
//    
//    [APP_DELEGATE.recognizer addReceiver: self];
//    [APP_DELEGATE.analyzer addRecognizer:APP_DELEGATE.recognizer];
//    
    
//    [self.view addSubview:circleChart];
    //self.title = @"iMonitor Ruido";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Metodos Arduino (leitura do sensor)

- (BOOL)lerDadosArduino{
    for (int i =0; i < 15; i++)
    [[[Bafometro shared] generator] writeByte:0x00];
    return YES;
}




#pragma mark - Metodos Clique dos botoes

- (IBAction)apagar:(id)sender {
    
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Conectando ao sensor..." message:@"Assopre o sensor..." delegate:nil cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Iniciar", nil];
//    alertView.alertViewStyle = FUIAlertViewStylePlainTextInput;
//    [@[[alertView textFieldAtIndex:0], [alertView textFieldAtIndex:1]] enumerateObjectsUsingBlock:^(FUITextField *textField, NSUInteger idx, BOOL *stop) {
//        [textField setTextFieldColor:[UIColor cloudsColor]];
//        [textField setBorderColor:[UIColor asbestosColor]];
//        [textField setCornerRadius:4];
//        [textField setFont:[UIFont flatFontOfSize:14]];
//        [textField setTextColor:[UIColor midnightBlueColor]];
//    }];
//    [[alertView textFieldAtIndex:0] setPlaceholder:@"Text here!"];
    
    alertView.delegate = self;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor turquoiseColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];

}

- (IBAction)buttonBafometer:(id)sender {
    [[[Bafometro shared] generator] writeByte:0xFF];
}

#pragma mark - Metodos Clique no circulo

-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

#pragma mark - Metodos AlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"Cancelou");
        [self.timer invalidate];
        self.timer = nil;
    }else{
        FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Bafometro..." message:@"Assopre o sensor e confirme" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alertView.delegate = self;
        alertView.titleLabel.textColor = [UIColor cloudsColor];
        alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        alertView.messageLabel.textColor = [UIColor cloudsColor];
        alertView.messageLabel.font = [UIFont flatFontOfSize:14];
        alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
        alertView.alertContainer.backgroundColor = [UIColor turquoiseColor];
        alertView.defaultButtonColor = [UIColor cloudsColor];
        alertView.defaultButtonShadowColor = [UIColor asbestosColor];
        alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
        alertView.defaultButtonTitleColor = [UIColor asbestosColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lerDadosArduino) userInfo:nil repeats:YES];
        [alertView show];
    }
    
}


@end

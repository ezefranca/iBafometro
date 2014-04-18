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
    
    
    
	PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 100.0, SCREEN_WIDTH, 100.0) andTotal:[NSNumber numberWithInt:100] andCurrent:[NSNumber numberWithInt:33] andClockwise:YES];
    circleChart.backgroundColor = [UIColor clearColor];
    [circleChart setStrokeColor:PNRed];
    [circleChart strokeChart];
    
// 
//    APP_DELEGATE.recognizer = [[FSKRecognizer alloc] init];
//    //APP_DELEGATE.analyzer = [[AudioSignalAnalyzer alloc] init];
//    [APP_DELEGATE.analyzer addRecognizer: APP_DELEGATE.recognizer]; // set recognizer to analyzer
//    [APP_DELEGATE.analyzer record]; // start analyzing
//    
//    [APP_DELEGATE.recognizer addReceiver: self];
//    [APP_DELEGATE.analyzer addRecognizer:APP_DELEGATE.recognizer];
//    
    
    [self.view addSubview:circleChart];
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

- (IBAction)apagar:(id)sender {
   // while (retorno != 33) {
       [[[Bafometro shared] generator] writeByte:0x00];
    //}
    
}

- (IBAction)buttonBafometer:(id)sender {
    [[[Bafometro shared] generator] writeByte:0xFF];
}

-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}




@end

//
//  SecondViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "BafometroVC.h"
#import "AppDelegate.h"
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
    
 
    APP_DELEGATE.recognizer = [[FSKRecognizer alloc] init];
    //APP_DELEGATE.analyzer = [[AudioSignalAnalyzer alloc] init];
    [APP_DELEGATE.analyzer addRecognizer: APP_DELEGATE.recognizer]; // set recognizer to analyzer
    [APP_DELEGATE.analyzer record]; // start analyzing
    
    [APP_DELEGATE.recognizer addReceiver: self];
    [APP_DELEGATE.analyzer addRecognizer:APP_DELEGATE.recognizer];
    
    
    [self.view addSubview:circleChart];
    //self.title = @"iMonitor Ruido";
}

-(void)receivedChar:(char)input
{
   NSLog(@"Input recebido %c", input);
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

- (IBAction)buttonBafometer:(id)sender {
    NSString* buttonKey = @"first";
    NSString* hex = [[NSUserDefaults standardUserDefaults] stringForKey:buttonKey];
    hex = [hex substringFromIndex:2];
    NSData* hexData = [hex hexToBytes];
    //NSLog(@"%@", hex);
    //NSLog(@"%@", [hex hexToBytes]);
    
	[APP_DELEGATE.generator writeByte:0x00];
  //  [APP_DELEGATE.generator writeBytes:[hexData bytes] length:hexData.length];
    
    
//    // Configure the view.
//    SKView * skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
//    
//    // Create and configure the scene.
//    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
//    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    // Present the scene.
//    [skView presentScene:scene];
}

-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

@end

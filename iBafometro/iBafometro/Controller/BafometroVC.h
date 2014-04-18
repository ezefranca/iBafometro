//
//  SecondViewController.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "AudioSignalAnalyzer.h"
#import "FSKSerialGenerator.h"
#import "FSKRecognizer.h"
#import "CharReceiver.h"

@interface BafometroVC : UIViewController <CharReceiver>{
    //FSKRecognizer *recognizer;
    //AudioSignalAnalyzer *analyzer;
}
- (IBAction)buttonBafometer:(id)sender;
@end

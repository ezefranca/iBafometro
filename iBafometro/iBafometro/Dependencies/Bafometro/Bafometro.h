//
//  Bafometro.h
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "CharReceiver.h"

@class AudioSignalAnalyzer, FSKSerialGenerator;

@interface Bafometro : NSObject <AVAudioSessionDelegate, CharReceiver>
@property (strong, nonatomic) AudioSignalAnalyzer* analyzer;
@property (strong, nonatomic) FSKSerialGenerator* generator;

+ (id)shared;

- (void)setLED:(BOOL)on;
@end

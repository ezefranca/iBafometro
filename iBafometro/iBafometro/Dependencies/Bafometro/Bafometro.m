//
//  Bafometro.m
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "Bafometro.h"
#import "CharReceiver.h"
#import "AudioSignalAnalyzer.h"
#import "FSKRecognizer.h"
#import "FSKSerialGenerator.h"

@implementation Bafometro {
    FSKRecognizer *_recognizer;
}

+ (id)shared {
    static id shared;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (id)init {
    if (self = [super init]) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interruption:) name:AVAudioSessionInterruptionNotification object:nil];
        if(session.inputAvailable) {
            NSLog(@"Input is available, playandrecord\n");
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        } else {
            NSLog(@"Input is available, playback\n");
            [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        }
        [session setActive:YES error:nil];
        [session setPreferredIOBufferDuration:0.023220 error:nil];
        
        _generator = [[FSKSerialGenerator alloc] init]; [_generator play];
        _recognizer = [[FSKRecognizer alloc] init];     [_recognizer addReceiver:self];
        _analyzer = [[AudioSignalAnalyzer alloc] init]; [_analyzer addRecognizer:_recognizer];
        
        if(session.inputAvailable){
            NSLog(@"Entrada disponivel, analyzer record\n");
            [self.analyzer record];
        }

    }
    return self;
}

- (void)inputIsAvailableChanged:(BOOL)isInputAvailable
{
	NSLog(@"inputIsAvailableChanged %d",isInputAvailable);
	
	AVAudioSession *session = [AVAudioSession sharedInstance];
	
	[self.analyzer stop];
	[self.generator stop];
	
	if(isInputAvailable){
		[session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
		[self.analyzer record];
	}else{
		[session setCategory:AVAudioSessionCategoryPlayback error:nil];
	}
	[self.generator play];
}

- (void)beginInterruption
{
	NSLog(@"beginInterruption");
    [self.analyzer stop];
    [self.generator pause];
}

- (void)endInterruption
{
	NSLog(@"endInterruption");
    [self.analyzer record];
    [self.generator resume];
}

- (void)endInterruptionWithFlags:(NSUInteger)flags
{
	NSLog(@"endInterruptionWithFlags: %x",flags);
}

- (void)setLED:(BOOL)on {
    [self.generator writeByte:0xFF];
}

- (void) receivedChar:(char)input {
    
    NSLog(@"Received: %d", input);
}

- (void) interruption:(NSNotification*)notification
{
    NSDictionary *interuptionDict = notification.userInfo;
    NSUInteger interuptionType = (NSUInteger)[interuptionDict valueForKey:AVAudioSessionInterruptionTypeKey];
    
    if (interuptionType == AVAudioSessionInterruptionTypeBegan)
        [self beginInterruption];
#if __CC_PLATFORM_IOS >= 40000
    else if (interuptionType == AVAudioSessionInterruptionTypeEnded)
        [self endInterruptionWithFlags:(NSUInteger)[interuptionDict valueForKey:AVAudioSessionInterruptionOptionKey]];
#else
    else if (interuptionType == AVAudioSessionInterruptionTypeEnded)
        [self endInterruption];
#endif
}

@end

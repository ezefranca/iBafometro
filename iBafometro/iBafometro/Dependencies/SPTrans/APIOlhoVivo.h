//
//  AmigosView.m
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIOlhoVivo : NSObject <NSURLConnectionDelegate>
{
    NSData *jsonDados;
}

@property NSString *token;
- (id)initWithToken:(NSString *)seuToken;
-(NSMutableDictionary *)busca:(NSString *)termosDaBusca comOtermo:(NSString *)tipoDeBusca;

@end
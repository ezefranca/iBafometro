//
//  DadosPessoais.h
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 15/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DadosPessoais : NSManagedObject

@property (nonatomic, retain) NSString * numerotaxi;
@property (nonatomic, retain) NSString * contatoamigo;
@property (nonatomic, retain) NSString * enderecocasa;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSNumber * id;

@end

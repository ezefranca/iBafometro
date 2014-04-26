//
//  AmigosView.m
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//
#import "APIOlhoVivo.h"

@interface APIOlhoVivo()
{
    NSMutableData *getResponseData;
}
@end

@implementation APIOlhoVivo

- (id)initWithToken:(NSString *)seuToken
{
    self = [super init];
    if (self) {
        _token = seuToken;
        //_token = @"67542d68a9ba2751de039bd09dd42473e1d6e51cbdc49ebfec2bc4d52fc32102";
    }
    [self autenticarOlhoVivo];
    return self;
}

#pragma mark Autentica API Olho vivo

-(void) autenticarOlhoVivo
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];;
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.olhovivo.sptrans.com.br/v0/Login/Autenticar?token=%@", _token]]];
    [request setHTTPMethod:@"POST"];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if( connection )
    {
        getResponseData = [NSMutableData new];
    }
}

#pragma mark Consulta API Olho vivo
// Veja a documentacao com os tipos de busca

-(NSMutableDictionary *)busca:(NSString *)termosDaBusca comOtermo:(NSString *)tipoDeBusca{
    
    NSString *strURL = [NSString stringWithFormat:@"http://api.olhovivo.sptrans.com.br/v0/%@/Buscar?termosBusca=%@",tipoDeBusca, termosDaBusca];
    NSURL *url = [NSURL URLWithString: strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:url];
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    // Esse cara aqui que vai estar com nosso binario do JSON
    NSData *ResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Erro no link %@, HTTP status %i", url, [responseCode statusCode]);
        return nil;
    }
    else{
        //NSLog(@"Tudo certo, go go gerar o JSON");
        NSError *error;
        NSMutableDictionary *jsonDadosUsuario = [NSJSONSerialization
                                                 JSONObjectWithData:ResponseData
                                                 options:NSJSONReadingMutableContainers
                                                 error:&error];
        
        //NSLog(@"%@", jsonDadosUsuario);
        return jsonDadosUsuario;
    }
}

#pragma mark DELEGATE NSURLCONNECTION
//Estes tres metodos abaixos sao do delegate NSURLConnetion

-(void) connection:(NSURLConnection*) connetion didReceiveData:(NSData *)data
{
    [getResponseData appendData:data];
    
}

-(void) connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    NSLog(@"error: %@", [error localizedDescription]);
}

-(void) connectionDidFinishLoading:(NSURLConnection*) connection
{
    //NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:getResponseData options:NSJSONReadingAllowFragments error:nil];
    //NSLog(@"result: %@", dict);
    NSString* myString;
    myString = [[NSString alloc] initWithData:getResponseData encoding:NSASCIIStringEncoding];
    NSLog(@"RECEBEU: %@", myString);
    //[self busca:@"RUA TREZE" comOtermo:@"Paradas"];
}

@end

//
//  TaxiView.m
//  iBafometro
//
//  Created by EZEQUIEL FRANCA DOS SANTOS on 16/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "TaxiVC.h"

@interface TaxiVC ()

@end

@implementation TaxiVC

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
    // Do any additional setup after loading the view.
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

- (IBAction)ligarTaxi1:(id)sender {
    [self ligandoTaxista];
}

- (IBAction)ligarTaxi2:(id)sender {
    [self ligandoTaxista];
}


- (void)ligandoTaxista{
    NSString *numeroTaxista = @"+919876543210";
    NSURL *telefoneURL = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",numeroTaxista]];
    
    if ([[UIApplication sharedApplication] canOpenURL:telefoneURL]) {
        [[UIApplication sharedApplication] openURL:telefoneURL];
    } else
    {
        NSLog(@"Nao foi possivel fazer sua ligacao");
    }
}
@end

//
//  SettingsViewController.h
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

@interface SettingsVC : UIViewController <UIApplicationDelegate>
- (IBAction)botaoSalvar:(id)sender;
- (IBAction)botaoConsulta:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *labelNome;
@property (weak, nonatomic) IBOutlet UITextField *labelTaxista;
@property (weak, nonatomic) IBOutlet UITextField *labelAmigo;
@property (weak, nonatomic) IBOutlet UITextField *labelEndereco;

@end

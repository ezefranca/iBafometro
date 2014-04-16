//
//  SettingsViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@interface SettingsViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSArray* coreDataArray;

@end

@implementation SettingsViewController




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

- (IBAction)botaoSalvar:(id)sender {


    // Limpar Labels
    self.labelNome.text = @"";
    self.labelTaxista.text = @"";
    self.labelAmigo.text = @"";
    self.labelEndereco.text = @"";
    
    // Acabou a edicao
    [self.view endEditing:YES];
    
    // Esconde o teclado
    [_labelAmigo resignFirstResponder];
    [_labelEndereco resignFirstResponder];
    [_labelNome resignFirstResponder];
    [_labelTaxista resignFirstResponder];
        
    // Criacao das strings para armazenar os dados
    NSString *usuarioNome = [self.labelNome text];
    NSString *numeroTaxi  = [self.labelTaxista text];
    NSString *endereco = [self.labelEndereco text];
    NSString *nomeAmigo = [self.labelAmigo text];
    
    // Criar as instancias de NSData
//        UIImage *contactImage = contactImageView.image;
//        NSData *imageData = UIImageJPEGRepresentation(contactImage, 100);
//        
    
    // Salvar os dados
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
    [defaults setObject:usuarioNome forKey:@"nome"];
    [defaults setObject:numeroTaxi forKey:@"taxi"];
    [defaults setObject:endereco forKey:@"enderco"];
    [defaults setObject:nomeAmigo forKey:@"amigo"];
//  [defaults setObject:imageData forKey:@"image"];
        
    [defaults synchronize];
        
    NSLog(@"Dados Salvos");
    
}

- (IBAction)botaoConsulta:(id)sender {

}

//Métodos para ocultacao do teclado
//esse bool precisa associar com
//Select the text field in the view and display the Connections Inspector (View -> Utilities -> Connections Inspector)
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
    
    /*
     // Get the stored data before the view loads
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
     NSString *firstName = [defaults objectForKey:@"firstName"];
     NSString *lastName = [defaults objectForKey:@"lastname"];
     
     int age = [defaults integerForKey:@"age"];
     NSString *ageString = [NSString stringWithFormat:@"%i",age];
     
     NSData *imageData = [defaults dataForKey:@"image"];
     UIImage *contactImage = [UIImage imageWithData:imageData];
     
     // Update the UI elements with the saved data
     firstNameTextField.text = firstName;
     lastNameTextField.text = lastName;
     ageTextField.text = ageString;
     contactImageView.image = contactImage;
    
    
    */
	return YES;
}




-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}


// Use this method also if you want to hide keyboard when user touch in background

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_labelAmigo resignFirstResponder];
    [_labelEndereco resignFirstResponder];
    [_labelNome resignFirstResponder];
    [_labelTaxista resignFirstResponder];
}


@end










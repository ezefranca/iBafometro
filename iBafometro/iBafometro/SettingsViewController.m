//
//  SettingsViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "DadosPessoais.h"


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
    
    //1
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //2
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    
    // Faz a consulta no coreData e retorna no array "coreDataArray"
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
    
    // Add Entry to PhoneBook Data base and reset all fields
    
    //  1
    DadosPessoais * novosDados = [NSEntityDescription insertNewObjectForEntityForName:@"DadosPessoais"
                                                      inManagedObjectContext:self.managedObjectContext];
    //  2
    novosDados.nome = self.labelNome.text;
    novosDados.numerotaxi = self.labelTaxista.text;
    novosDados.contatoamigo = self.labelAmigo.text;
    novosDados.enderecocasa = self.labelEndereco.text;
    
    //  3
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    //  4
    self.labelNome.text = @"";
    self.labelTaxista.text = @"";
    self.labelAmigo.text = @"";
    self.labelEndereco.text = @"";
    
    //  5
    [self.view endEditing:YES];
    
    
}

- (IBAction)botaoConsulta:(id)sender {
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DadosPessoais"];
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"nome"];
    //[request setPredicate:pred];
    DadosPessoais *busca = nil;
    
    NSError *error;
    NSArray *objetos = [context executeFetchRequest:request error:&error];
    
    if ([objetos count] == 0) {
        NSLog(@"Vazio");
    }else {
        
        NSLog(@"%@", objetos);
    }
    
//    self.coreDataArray = [appDelegate consultaCoreData];
//    DadosPessoais *dados = [self.coreDataArray objectAtIndex:1];
//    NSLog(@"Nome: %@ - Taxi: %@", dados.nome, dados.numerotaxi);
}

//Métodos para ocultacao do teclado
//esse bool precisa associar com
//Select the text field in the view and display the Connections Inspector (View -> Utilities -> Connections Inspector)
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
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










//
//  SettingsViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "SettingsVC.h"
#import "AppDelegate.h"
#import "DTAlertView.h"

@interface SettingsVC ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSArray* coreDataArray;

@end

@implementation SettingsVC




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
    
    
    DTAlertView *alertView = [DTAlertView alertViewWithTitle:@"Please Input Password!!" message:@"Password is \"1234567890\"" delegate:self cancelButtonTitle:@"Cancel" positiveButtonTitle:@"OK"];
    [alertView setAlertViewMode:DTAlertViewModeTextInput];
    [alertView setPositiveButtonEnable:YES];
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
 //   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    [[NSUserDefaults standardUserDefaults] setObject:usuarioNome forKey:@"nome"];
    [[NSUserDefaults standardUserDefaults] setObject:numeroTaxi forKey:@"taxi"];
    [[NSUserDefaults standardUserDefaults] setObject:endereco forKey:@"endereco"];
    [[NSUserDefaults standardUserDefaults] setObject:nomeAmigo forKey:@"amigo"];
//  [defaults setObject:imageData forKey:@"image"];
        
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    NSLog(@"Dados Salvos");
    
    // Limpar Labels
    self.labelNome.text = @"";
    self.labelTaxista.text = @"";
    self.labelAmigo.text = @"";
    self.labelEndereco.text = @"";
    
    [alertView show];
    
}

- (IBAction)botaoConsulta:(id)sender {
    
    // Get the stored data before the view loads
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *usuarioNome = [[NSUserDefaults standardUserDefaults] stringForKey:@"nome"];
    
    NSLog(@"Nome: %@", usuarioNome);
    
}

- (IBAction)botaoAmigo:(id)sender {
    //NSString *nomeAmigo = [[NSString alloc]init];

    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error) {
                                          if (error) {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:error.localizedDescription
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                              [alertView show];
                                          } else if (session.isOpen) {
                                              [self botaoAmigo:sender];
                                          }
                                      }];
        return;
    }
    
    if (self.friendPickerController == nil) {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Selecionar Amigo";
        self.friendPickerController.delegate = self;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    
    [self presentViewController:self.friendPickerController animated:YES completion:nil];

    
}

- (void)facebookViewControllerDoneWasPressed:(id)sender {
    NSMutableString *text = [[NSMutableString alloc] init];
    
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        if ([text length]) {
            [text appendString:@", "];
        }
        [text appendString:user.name];
    }
    
    [self fillTextBoxAndDismiss:text.length > 0 ? text : @"<None>"];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender {
    [self fillTextBoxAndDismiss:@"<Cancelled>"];
}

- (void)fillTextBoxAndDismiss:(NSString *)text {
    self.labelAmigo.text = text;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
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










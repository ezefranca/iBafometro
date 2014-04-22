//
//  SettingsViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "SettingsVC.h"
#import "AppDelegate.h"

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
    [self showTabBar];
    
    //--------- Customizacao botoes
    
    self.botaoAmigo.buttonColor = [UIColor cloudsColor];
    self.botaoAmigo.shadowColor = [UIColor asbestosColor];
    self.botaoAmigo.shadowHeight = 3.0f;
    self.botaoAmigo.cornerRadius = 6.0f;
    self.botaoAmigo.titleLabel.font = [UIFont boldFlatFontOfSize:12];
    [self.botaoAmigo setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
    [self.botaoAmigo setTitleColor:[UIColor asbestosColor] forState:UIControlStateHighlighted];
    
    self.botaoSalvar.buttonColor = [UIColor cloudsColor];
    self.botaoSalvar.shadowColor = [UIColor asbestosColor];
    self.botaoSalvar.shadowHeight = 3.0f;
    self.botaoSalvar.cornerRadius = 6.0f;
    self.botaoSalvar.titleLabel.font = [UIFont boldFlatFontOfSize:12];
    [self.botaoSalvar setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
    [self.botaoSalvar setTitleColor:[UIColor asbestosColor] forState:UIControlStateHighlighted];
    
    self.botaoConsulta.buttonColor = [UIColor cloudsColor];
    self.botaoConsulta.shadowColor = [UIColor asbestosColor];
    self.botaoConsulta.shadowHeight = 3.0f;
    self.botaoConsulta.cornerRadius = 6.0f;
    self.botaoConsulta.titleLabel.font = [UIFont boldFlatFontOfSize:12];
    [self.botaoConsulta setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
    [self.botaoConsulta setTitleColor:[UIColor asbestosColor] forState:UIControlStateHighlighted];

    
    //---------
    
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"senha"];
    if([password isEqual:nil] || [password isEqual:@"SENHA"]){
        NSLog(@"Sem senha");
    }
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

#pragma mark - Metodo para salvar com NSDeafults

-(void)salvarDados{
    
    
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
    NSString *password = self.alertView.messageLabel.text;
    
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
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"senha"];
    //  [defaults setObject:imageData forKey:@"image"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%@", password);
    
    // Limpar Labels
    self.labelNome.text = @"";
    self.labelTaxista.text = @"";
    self.labelAmigo.text = @"";
    self.labelEndereco.text = @"";
    
    // Acabou a edicao
    [self.view endEditing:YES];
}


- (IBAction)botaoSalvar:(id)sender {
    
    
    self.alertView = [[FUIAlertView alloc] initWithTitle:@"Salvar Dados" message:@"SENHA" delegate:nil cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Ok", nil];
    
    self.alertView.alertViewStyle = FUIAlertViewStyleLoginAndPasswordInput;
        [@[[self.alertView textFieldAtIndex:0]] enumerateObjectsUsingBlock:^(FUITextField *textField, NSUInteger idx, BOOL *stop) {
            [textField setTextFieldColor:[UIColor cloudsColor]];
            [textField setBorderColor:[UIColor asbestosColor]];
            [textField setCornerRadius:4];
            [textField setFont:[UIFont flatFontOfSize:14]];
            [textField setTextColor:[UIColor midnightBlueColor]];
            }];
    [[self.alertView textFieldAtIndex:0] setPlaceholder:@"Digite ou Cadastre sua senha"];
    [[self.alertView textFieldAtIndex:1]setEnabled:NO];
    
    self.alertView.delegate = self;
    self.alertView.titleLabel.textColor = [UIColor cloudsColor];
    self.alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    self.alertView.messageLabel.textColor = [UIColor cloudsColor];
    self.alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    self.alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    self.alertView.alertContainer.backgroundColor = [UIColor turquoiseColor];
    self.alertView.defaultButtonColor = [UIColor cloudsColor];
    self.alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    self.alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    self.alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [self.alertView show];
}

#pragma mark - Metodo para Consulta dos valores salvos

- (IBAction)botaoConsulta:(id)sender {
    
    // Get the stored data before the view loads
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *usuarioNome = [[NSUserDefaults standardUserDefaults] stringForKey:@"nome"];
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"senha"];
    NSLog(@"Nome: %@ Senha: %@", usuarioNome, password);
    
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


// Use this method also if you want to hide keyboard when user touch in background

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_labelAmigo resignFirstResponder];
    [_labelEndereco resignFirstResponder];
    [_labelNome resignFirstResponder];
    [_labelTaxista resignFirstResponder];
}

#pragma mark metodos AlertView

- (void)alertView:(FUIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"Cancelou");
    }
    else{
        if ([[[[self alertView]textFieldAtIndex:0]text] isEqual:@"SENHA"]){
        [self salvarDados];
        NSLog(@"era pra ter salvado dados %ld", (long)buttonIndex);
        }
    }
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [self showTabBar];
}

- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:1
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
    
    // 1
}

- (void)showTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
                         tabBar.frame = tabFrame;
                         
                         CGRect contentFrame = content.frame;
                         contentFrame.size.height -= tabFrame.size.height;
                     }];
    
    // 2
    
    
}

@end










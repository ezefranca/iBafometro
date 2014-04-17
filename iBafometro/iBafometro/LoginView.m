//
//  FirstViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 11/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()

@end

@implementation LoginView

- (void)viewDidLoad
{
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
    //[[self tabBar] setSelectedImageTintColor:[UIColor greenColor]];
   // CGRect x = self.facebuquis.bounds;
    self.facebuquis.layer.cornerRadius = 5;
    self.facebuquis.layer.borderWidth = 1.0f;
    self.facebuquis.layer.borderColor = [UIColor clearColor].CGColor;
    self.facebuquis.clipsToBounds = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MainTabViewController.m
//  iBafometro
//
//  Created by Ezequiel Franca dos Santos on 13/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MainTabVC.h"

@interface MainTabVC ()

@end

@implementation MainTabVC

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
    [[self tabBar] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    
    // set color of selected icons and text to red
    self.tabBar.tintColor = [UIColor redColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    // set color of unselected text to green
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateNormal];
    
    // set selected and unselected icons
    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [self.tabBar.items objectAtIndex:3];
    
    // this way, the icon gets rendered as it is (thus, it needs to be green in this example)
    item0.image = [[UIImage imageNamed:@"target.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"spiral.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"map-pin.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"id-card.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // this icon is used for selected tab and it will get tinted as defined in self.tabBar.tintColor
    item0.selectedImage = [UIImage imageNamed:@"target"];
    item1.selectedImage = [UIImage imageNamed:@"spiral"];
    item2.selectedImage = [UIImage imageNamed:@"map-pin"];
    item3.selectedImage = [UIImage imageNamed:@"id-card"];
    
    
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

@end

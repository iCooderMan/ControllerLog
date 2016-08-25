//
//  HomeViewController.m
//  ControllerLog
//
//  Created by Almas on 16/8/25.
//  Copyright © 2016年 Ali. All rights reserved.
//

#import "HomeViewController.h"
#import "SecondViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (IBAction)pushToSecondVC:(id)sender {

    SecondViewController *vc = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end

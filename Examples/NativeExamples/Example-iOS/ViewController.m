//
//  ViewController.m
//  Example-iOS
//
//  Created by fuziki on 2021/05/12.
//

#import "ViewController.h"

@import SwiftPmPlugin;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"value: %lld", swiftPmPlugin_toNumber("20"));
}


@end

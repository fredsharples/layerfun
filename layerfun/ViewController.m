//
//  ViewController.m
//  layerfun
//
//  Created by Fred Sharples on 5/29/13.
//  Copyright (c) 2013 Fred Sharples. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //FS Having the layer code here doesn't work. The frame code fails. Add this to viewDidAppear instead.
    
    //self.view.layer.backgroundColor = [UIColor orangeColor].CGColor;
    //self.view.layer.cornerRadius = 20.0;
    //self.view.layer.frame = CGRectInset(self.view.layer.frame, 20, 20);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view.layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.view.layer.cornerRadius = 20.0;
    self.view.layer.frame = CGRectInset(self.view.layer.frame, 20, 20);
    
    ///
    
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor blueColor].CGColor;
    sublayer.shadowOffset = CGSizeMake(0, 3);
    sublayer.shadowRadius = 5.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 0.8;
    sublayer.frame = CGRectMake(30, 30, 128, 192);
    sublayer.borderColor = [UIColor blackColor].CGColor;
    sublayer.cornerRadius = 10.0;
    sublayer.borderWidth = 2.0;
    [self.view.layer addSublayer:sublayer];
   
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = sublayer.bounds;
    imageLayer.cornerRadius = 10.0;
    imageLayer.contents = (id) [UIImage imageNamed:@"tiger_door.jpg"].CGImage;
    imageLayer.masksToBounds = YES;
    [sublayer addSublayer:imageLayer];
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

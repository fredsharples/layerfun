//
//  ViewController.m
//  layerfun
//
//  Created by Fred Sharples on 5/29/13.
//  Copyright (c) 2013 Fred Sharples. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

static inline double radians (double degrees)
{
    return degrees * M_PI/180;
}


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
    
    CALayer *customDrawn = [CALayer layer];
    customDrawn.delegate = self;
    customDrawn.backgroundColor = [UIColor greenColor].CGColor;
    customDrawn.frame = CGRectMake(30, 250, 128, 40);
    customDrawn.shadowOffset = CGSizeMake(0, 30);
    customDrawn.shadowRadius = 5.0;
    customDrawn.shadowColor = [UIColor blackColor].CGColor;
    customDrawn.shadowOpacity = 0.8;
    customDrawn.cornerRadius = 10.0;
    customDrawn.borderColor = [UIColor blackColor].CGColor;
    customDrawn.borderWidth = 2.0;
    customDrawn.masksToBounds = YES;
    [self.view.layer addSublayer:customDrawn];
    [customDrawn setNeedsDisplay];
    
    [self FadeMyLayer:imageLayer];
    [self MoveMyLayerWithBlocks:imageLayer];
    
   /* CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithFloat:1.0];
    fadeAnim.toValue = [NSNumber numberWithFloat:0.0];
    fadeAnim.duration = 4.0;
    [imageLayer addAnimation:fadeAnim forKey:@"opacity"];
    
    imageLayer.opacity = 0.0;
    */
}
 
- (void) MoveMyLayerWithBlocks:(CALayer *)myLayer {
    
    //int multiplier = 7;
    //int (^myBlock)(int) = ^(int num) {return num * multiplier;};
    //printf("%d", myBlock(3));
    
    void (^setVars)(CGPoint,int,CGFloat) = ^(CGPoint fromPoint, int animationDistance, CGFloat animationDuration){
        NSValue *fromPointValue = [NSValue valueWithCGPoint:fromPoint];
        CABasicAnimation* moveAnim = [CABasicAnimation animationWithKeyPath:@"position"];
        moveAnim.fromValue = fromPointValue;
        CGPoint toPoint = CGPointMake(myLayer.position.x,animationDistance);
        moveAnim.toValue = [NSValue valueWithCGPoint:toPoint];
        moveAnim.duration = animationDuration;
        [myLayer addAnimation:moveAnim forKey:@"position"];
        
        myLayer.position = fromPoint;

    };
    
    setVars(myLayer.position,-100,4.0);
    
    //declare variables
    //CGPoint fromPoint = myLayer.position;
   // NSValue *fromPointValue = [NSValue valueWithCGPoint:fromPoint];
    //int animationDistance = -100;
    //CGFloat animationDuration = 4.0;
    /*
    CABasicAnimation* moveAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnim.fromValue = fromPointValue;
    CGPoint toPoint = CGPointMake(myLayer.position.x,animationDistance);
    moveAnim.toValue = [NSValue valueWithCGPoint:toPoint];
    moveAnim.duration = animationDuration;
    [myLayer addAnimation:moveAnim forKey:@"position"];
    
    myLayer.position = fromPoint;
     */
    
}

    //printf("%d", myBlock(3));

- (void) MoveMyLayer:(CALayer *)myLayer {
    CGPoint startPos = myLayer.position;
    
    NSValue *initialPosition = [NSValue valueWithCGPoint:myLayer.position];
    
    CABasicAnimation* moveAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnim.fromValue = initialPosition;
    
    CGPoint toPoint = CGPointMake(myLayer.position.x,-100);
    
    moveAnim.toValue = [NSValue valueWithCGPoint:toPoint];
    moveAnim.duration = 4.0;
    [myLayer addAnimation:moveAnim forKey:@"position"];
    
    myLayer.position = startPos;
}

- (void) FadeMyLayer:(CALayer *)myLayer {
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithFloat:1.0];
    fadeAnim.toValue = [NSNumber numberWithFloat:0.0];
    fadeAnim.duration = 4.0;
    [myLayer addAnimation:fadeAnim forKey:@"opacity"];
    
    myLayer.opacity = 0.0;
    
}
void MyDrawColoredPattern (void *info, CGContextRef context) {
    
    CGColorRef dotColor = [UIColor colorWithHue:0.0 saturation:0.0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0,1),1, shadowColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, radians (360.0), 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 16, 16, 4, 0, radians (360.0), 0);
    CGContextFillPath(context);
    
}

- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    
    CGColorRef bgColor = [UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
    
    
    CGContextSetFillColorWithColor(context, bgColor);
    CGContextFillRect(context, layer.bounds);
    
    
    static const CGPatternCallbacks callbacks = { 0, &MyDrawColoredPattern, NULL };
    
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL, layer.bounds, CGAffineTransformIdentity, 24.0, 24.0, kCGPatternTilingConstantSpacing, true, &callbacks);
    
    
    
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, layer.bounds);
    CGContextRestoreGState(context);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  Pong
//
//  Created by Nicolas Semenas on 31/07/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "BallView.h"


@interface ViewController () <UICollisionBehaviorDelegate>

@property (weak, nonatomic) IBOutlet BallView *ballView;
@property (weak, nonatomic) IBOutlet PaddleView *paddleView;

@property UIDynamicAnimator *dynamicAnimator;
@property UIPushBehavior *pushBehaviour;
@property UICollisionBehavior *collitionBehavior;
@property UIDynamicItemBehavior *ballDynamicBehavior;
@property UIDynamicItemBehavior *paddleDynamicBehavior;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.pushBehaviour = [[UIPushBehavior alloc] initWithItems:@[self.ballView]
                                                          mode:UIPushBehaviorModeInstantaneous];

    self.pushBehaviour.pushDirection = CGVectorMake(0.5, 1.0);
    self.pushBehaviour.active = YES;
    self.pushBehaviour.magnitude = 0.2;
    [self.dynamicAnimator addBehavior:self.pushBehaviour];
    
    self.collitionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.ballView, self.paddleView]];
    self.collitionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    self.collitionBehavior.collisionDelegate = self;
    self.collitionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.dynamicAnimator addBehavior:self.collitionBehavior];
    
    self.ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
    self.ballDynamicBehavior.allowsRotation = NO;
    self.ballDynamicBehavior.elasticity = 1.0;
    self.ballDynamicBehavior.friction = 0;
    self.ballDynamicBehavior.resistance = 0;
    [self.dynamicAnimator addBehavior:self.ballDynamicBehavior];
    
    self.paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.paddleView]];
    self.paddleDynamicBehavior.allowsRotation = NO;
    self.paddleDynamicBehavior.density = 1000;
    [self.dynamicAnimator addBehavior:self.paddleDynamicBehavior];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p{
    NSLog(@"Collided"); 
}


-(IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer{

    self.paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x, self.paddleView.center.y);
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView];
    
}

@end

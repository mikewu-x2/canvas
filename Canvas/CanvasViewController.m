//
//  CanvasViewController.m
//  Canvas
//
//  Created by Michael Wu on 9/17/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()
@property (weak, nonatomic) IBOutlet UIView *trayView;
@property (strong, nonatomic) UIImageView *newlyCreatedFace;

@property CGPoint faceCenter;
@property CGPoint trayIsOpen;
@property CGPoint trayIsClosed;

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.trayIsOpen = CGPointMake(self.view.frame.size.width / 2, 600);
    self.trayIsClosed = CGPointMake(self.view.frame.size.width / 2, 830);
    
    self.trayView.center = self.trayIsClosed;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onSmileyPanGesture:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            NSLog(@"Smiley Start");
            UIImageView *imageView = (UIImageView *)sender.view;
            self.newlyCreatedFace = [[UIImageView alloc] initWithImage:imageView.image];
            [self.view addSubview:self.newlyCreatedFace];
            self.newlyCreatedFace.center = CGPointMake(imageView.center.x, imageView.center.y + self.trayView.frame.origin.y);
            self.faceCenter = self.newlyCreatedFace.center;

            break;
        }
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Smiley cancel");
            break;
        case UIGestureRecognizerStateChanged: {
            NSLog(@"Smiley Changed");
            
            //CGPoint velocity = [sender velocityInView:self.trayView];
            CGPoint translation = [sender translationInView:self.trayView];
            self.newlyCreatedFace.center = CGPointMake(self.faceCenter.x + translation.x, self.faceCenter.y + translation.y);
            //NSLog(@"center %f, %f", self.trayView.center.x, self.trayView.center.y);
            
            
            break;
        }
        case UIGestureRecognizerStateEnded:
            NSLog(@"Smiley Ended");

            break;
        default:
            NSLog(@"Default");
            break;
            
    }

    
}

- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender {
    
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan:
            NSLog(@"Began %f, %f", self.trayView.center.x, self.trayView.center.y);
            //self.trayOriginalCenter = self.trayView.center;
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Cancelled");
            break;
        case UIGestureRecognizerStateChanged: {
            NSLog(@"Changed");
            //CGPoint translation = [sender translationInView:self.trayView];
            CGPoint velocity = [sender velocityInView:self.trayView];
            //self.trayView.center = CGPointMake(self.trayOriginalCenter.x, self.trayOriginalCenter.y + translation.y);
            //NSLog(@"center %f, %f", self.trayView.center.x, self.trayView.center.y);
            
            //if (velocity.y > 0) {
                //CGPoint trayPosition = self.trayIsClosed;
                //self.trayView.center = self.trayIsClosed;
            //} else {
                //CGPoint trayPosition = self.trayIsOpen;
                //self.trayView.center = self.trayIsOpen;
            //}
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.01 options:0 animations:^{
                if (velocity.y > 0) {
                    //CGPoint trayPosition = self.trayIsClosed;
                    self.trayView.center = self.trayIsClosed;
                } else {
                    //CGPoint trayPosition = self.trayIsOpen;
                    self.trayView.center = self.trayIsOpen;
                }
                //self.trayView.center = trayPosition;
                [self.trayView layoutIfNeeded];
            }completion:nil];
            
            break;
        }
        case UIGestureRecognizerStateEnded:
            NSLog(@"Ended");
            //self.trayView.center = self.trayOriginalCenter;
            break;
        default:
            NSLog(@"Default");
            break;
            
    }
    
//    self.trayOriginalCenter = self.trayView.center;
//    CGPoint translation = [sender locationInView:self.trayView];
//    self.trayView.center.x = self.trayOriginalCenter.x + diffPoint.x;
//    self.trayView.center.y = self.trayOriginalCenter.y + diffPoint.y;
//    
    //NSLog(@"%@", self.trayOriginalCenter);
    //var point = panGestureRecognizer.locationInView(view)
    //var velocity = panGestureRecognizer.velocityInView(view)
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

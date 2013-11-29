//
//  ViewController.m
//  flipEffect
//
//  Created by gisxing on 13-11-26.
//  Copyright (c) 2013年 bilibala.net. All rights reserved.
//

#import "ViewController.h"
#import "WUIImage.h"
#import "CMSCoinView.h"


@interface ViewController ()



@property (strong, nonatomic) NSMutableArray *flipViews;

@property (strong, nonatomic) NSDictionary *dict ;
@property (strong, nonatomic) NSDictionary *dict_back ;

@property (strong, nonatomic) IBOutlet UIButton *flip_button ;
@end

int SPLIT_X = 6;
int SPLIT_Y = 6;

@implementation ViewController

- (void)viewDidAppear: (BOOL)animated {
    [super viewDidAppear:animated];

    [self.view bringSubviewToFront: self.flip_button];
    // 修改位置 不能在 vieDidLoad 里面， 可以放到viewDidAppear 里面
    
    //位置整理
    
	for (int i=0; i<SPLIT_X; i++)
	{
		for (int j=0; j<SPLIT_Y; j++)
		{
            CMSCoinView *tempView = self.flipViews[i][j];
            CGRect rect = [[[self.flipViews objectAtIndex:i] objectAtIndex:j] frame];
            CGRect newRect = CGRectMake(i*rect.size.width , j*rect.size.height, rect.size.width, rect.size.height);
            //NSLog(@"%f, %f", newRect.origin.x, newRect.origin.y);
            tempView.frame = newRect;
		}
	}
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.dict=[WUIImage SeparateImage:[UIImage imageNamed:@"Skull_Hd_640x960_230.jpg"] ByX:SPLIT_X andY:SPLIT_X cacheQuality:1.0];
    self.dict_back = [WUIImage SeparateImage:[UIImage imageNamed:@"iphone-4-wallpaper-640x960-71.jpg"] ByX:SPLIT_X andY:SPLIT_Y cacheQuality:1.0];
	NSLog(@"home directory: %@",NSHomeDirectory());
    
    //put all images in flipViews
    
    NSString *prefixName = @"win";
    self.flipViews = [[NSMutableArray alloc] init];
    for (int i=0; i<SPLIT_X; i++)
	{
       // [self.flipViews addObject: [[NSMutableArray alloc] init]];
		NSMutableArray *rowArray = [NSMutableArray array];
        for (int j=0; j<SPLIT_Y; j++)
		{
            
            NSString* _imageString=[NSString stringWithFormat:@"%@_%d_%d.jpg", prefixName, i, j];
            CMSCoinView * temp = [[CMSCoinView alloc] initWithPrimaryView: [self.dict objectForKey: _imageString]
                                                         andSecondaryView: [self.dict_back objectForKey: _imageString]
                                                                  inFrame: [[self.dict objectForKey: _imageString] frame]];
            [rowArray addObject: temp];
            [self.view addSubview: temp];

		}
        [self.flipViews addObject: rowArray];
	}
    NSLog(@"%d", [self.flipViews count]);
    
}


#pragma mark -
#pragma flip them all !

- (IBAction)FlipButton:(id)sender {
    for (int i=0; i<SPLIT_X; i++)
	{
        
		for (int j=0; j<SPLIT_Y; j++)
		{
            //[NSThread sleepForTimeInterval:0.5];
            CMSCoinView *tempView = self.flipViews[i][j];
            [tempView setSpinTime: drand48()];
            [tempView flipTouched: sender];
		}
	}
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

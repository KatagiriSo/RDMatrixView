//
//  ViewController.m
//  LayoutCorrectionTest
//
//  Created by katagiri on 2013/01/26.
//  Copyright (c) 2013年 RodhosSoft. All rights reserved.
//

#import "MatrixView.h"
#import "ViewController.h"

@interface CellView : UIView
@property (nonatomic, weak)IBOutlet UILabel *label;
@end

@implementation CellView
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.matrixView.maxY = 50;
    self.matrixView.maxX = 50;
    self.matrixView.cellView = [self makeCellView];
    
    [self.matrixView setUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (UIView*)viewForx:(NSInteger)x y:(NSInteger)y
{
    CellView *v = [self makeCellView];
    v.label.text = [NSString stringWithFormat:@"%d %d",x,y];
    return v;
}

- (CellView *)makeCellView
{
    CellView *v = [[CellView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    v.backgroundColor = [UIColor redColor];
    UILabel *vv = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    vv.backgroundColor = [UIColor clearColor];
    vv.textColor = [UIColor blackColor];
    vv.font = [UIFont systemFontOfSize:10];
    vv.text = @"0";
    [v addSubview:vv];
    v.label = vv;
    return v;
}

@end

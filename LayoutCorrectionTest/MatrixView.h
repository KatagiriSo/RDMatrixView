//
//  MatrixView.h
//  LayoutCorrectionTest
//
//  Created by katagiri on 2013/01/26.
//  Copyright (c) 2013年 RodhosSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MatrixViewProtocol <NSObject>
- (UIView *)viewForx:(NSInteger)x y:(NSInteger)y;
@end

@interface MatrixView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger maxX;
@property (nonatomic, assign) NSInteger maxY;
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, weak) IBOutlet id<MatrixViewProtocol> matrixDelegate;
- (void)setUp;
@end

//
//  MatrixView.h
//  RDMatrixView
//
//  Created by katagiri on 2013/01/26.
//  Copyright (c) 2013年 RodhosSoft. Distributed under the MIT license.
//

#import <UIKit/UIKit.h>
@class  RDMatrixView;

@protocol MatrixViewProtocol <NSObject>
- (UIView *)matrixView:(RDMatrixView *)matrixView viewForx:(NSInteger)x y:(NSInteger)y;
@optional
- (void)matrixView:(RDMatrixView *)matrixView tappedForx:(NSInteger)x y:(NSInteger)y;
@end

@interface RDMatrixView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger maxX;
@property (nonatomic, assign) NSInteger maxY;
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, assign) BOOL tapEnabled;
@property (nonatomic, weak) IBOutlet id<MatrixViewProtocol> matrixDelegate;
- (void)setUp;
@end

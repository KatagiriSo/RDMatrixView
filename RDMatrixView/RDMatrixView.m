//
//  MatrixView.m
//  RDMatrixView
//
//  Created by katagiri on 2013/01/26.
//  Copyright (c) 2013年 RodhosSoft. Distributed under the MIT license.
//

#import "RDMatrixView.h"
@interface RDMatrixView()
@property (nonatomic, strong) UIView *baseView;
@end

@implementation RDMatrixView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
    }
    return self;
}

- (void)awakeFromNib
{
    self.delegate = self;
}


-(NSInteger)numberRegion:(NSInteger)region targetSize:(NSInteger)tarSize
{
    if (!tarSize) {
        NSLog(@"[Error]numberRegion:%d targetSize:%d)", region, tarSize);
        return 0;
    }
    
    return (NSInteger)(region / tarSize);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

- (void)layoutSubviews
{
    [self updateMatrix:[self bounds]];
    [super layoutSubviews];
}

- (void)deleteOutView:(CGRect)rect
{
    for (UIView *v in self.baseView.subviews)
        if (!(CGRectIntersectsRect(v.frame, rect))) [v removeFromSuperview];
}

- (void)updateMatrix:(CGRect)rect
{
    [self deleteOutView:rect];
    
    float x = (rect.origin.x>0) ? rect.origin.x : 0;
    float y = (rect.origin.y>0) ? rect.origin.y : 0;
    
    // Drawing code
    NSInteger startXNum = [self numberRegion:x
                                  targetSize:self.cellView.frame.size.width];
    NSInteger endXNum = [self numberRegion:x+rect.size.width
                                targetSize:self.cellView.frame.size.width] + 1;
    
    NSInteger startYNum = [self numberRegion:y
                                  targetSize:self.cellView.frame.size.height];
    NSInteger endYNum = [self numberRegion:y+rect.size.height
                                targetSize:self.cellView.frame.size.height] + 1;
    
    if (endXNum >= self.maxX) endXNum = self.maxX;
    if (endYNum >= self.maxY) endYNum = self.maxY;
    
    for (int iy = startYNum ; iy<endYNum ;iy++) for (int ix = startXNum; ix<endXNum; ix++)
    {
        NSInteger keyNum = iy*1000+ix+1;
        if ([self.baseView viewWithTag:keyNum]) continue;
        
        UIView *v = [self.matrixDelegate matrixView:self viewForx:ix y:iy];
        v.tag = keyNum;
        v.frame = CGRectMake(0.0f + self.cellView.frame.size.width * ix,
                             0.0f + self.cellView.frame.size.height * iy,
                             v.frame.size.width,
                             v.frame.size.height);
        if (self.tapEnabled) {
            UITapGestureRecognizer *taoGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(tap:)];
            [v addGestureRecognizer:taoGesture];
        }
    
        
        [self.baseView addSubview:v];
    }
}

- (void)setUpBaseView
{
    if (self.baseView.superview) [self.baseView removeFromSuperview];
    
    
    CGRect rect = CGRectMake(0,
                             0,
                             self.cellView.frame.size.width * self.maxX,
                             self.cellView.frame.size.height * self.maxY);
    
    self.baseView = [[UIView alloc] initWithFrame:rect];
    [self addSubview:self.baseView];
    
    self.contentSize = rect.size;
}

- (void)setUp
{
    [self setUpBaseView];
}

- (NSInteger)xforCell:(UIView *)view
{
    return view.tag % 1000;
}

- (NSInteger)yforCell:(UIView *)view
{
    return (NSInteger)(view.tag/1000);
}

#pragma mark - 

- (void)tap:(UITapGestureRecognizer *)gesture
{
    UIView *v = gesture.view;
    [self.matrixDelegate matrixView:self
                         tappedForx:[self xforCell:v]
                                  y:[self yforCell:v]];
}






@end


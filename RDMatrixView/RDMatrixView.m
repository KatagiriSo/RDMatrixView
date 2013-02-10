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
@property (nonatomic, strong) NSMutableDictionary *displayViewDic;
@end

@implementation RDMatrixView

- (void)setMaxX:(NSInteger)maxX
{
    _maxX = maxX;
    [self setUpBaseView];
}

- (void)setMaxY:(NSInteger)maxY
{
    _maxY = maxY;
    [self setUpBaseView];
}

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
        NSInteger keyNum = [self tagForx:ix y:iy];
        if ([self existTag:keyNum]) continue;
        
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

- (void)setUpDisplayViewDic
{
    self.displayViewDic = [NSMutableDictionary dictionary];
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
    [self setUpDisplayViewDic];
    [self setUpBaseView];
}

- (UIView *)viewTag:(NSInteger)tag
{
    return (UIView *)[self.displayViewDic objectForKey:[self strForTag:tag]];
}

- (BOOL)existTag:(NSInteger)tag
{
    return ([self viewTag:tag] != nil);
}

- (NSString *)strForTag:(NSInteger)tag
{
    return [NSString stringWithFormat:@"%d",tag];
}

- (NSInteger)tagForx:(NSInteger)x y:(NSInteger)y
{
    return  y*1000+x+1;
}

- (NSInteger)xforTag:(NSInteger)tag
{
    return tag % 1000 - 1;
}

- (NSInteger)yforTag:(NSInteger)tag
{
    return (NSInteger)(tag/1000);
}

- (NSInteger)xforCell:(UIView *)view
{
    return [self xforTag:view.tag];
}

- (NSInteger)yforCell:(UIView *)view
{
    return [self yforTag:view.tag];
}

#pragma mark -

- (void)tap:(UITapGestureRecognizer *)gesture
{
    UIView *v = gesture.view;
    
    if ([self.matrixDelegate respondsToSelector:@selector(matrixView:tappedForx:y:)]) {
        [self.matrixDelegate matrixView:self
                             tappedForx:[self xforCell:v]
                                      y:[self yforCell:v]];
    }
}






@end


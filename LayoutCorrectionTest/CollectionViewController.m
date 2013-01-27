//
//  CollectionViewController.m
//  LayoutCorrectionTest
//
//  Created by katagiri on 2013/01/26.
//  Copyright (c) 2013年 RodhosSoft. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark -

+ (int)kuriageWarizan:(int)wararerukazu waru:(int)warukazu
{
    if (warukazu==0) {
        NSLog(@"[Error] kuriageWarizan:%d waru:%d", wararerukazu, warukazu);
        return 0;
    }
    return wararerukazu / warukazu + ((wararerukazu % warukazu == 0) ? 0 : 1);
}


+ (NSInteger)repNumForCollectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell
{
    //ビューの横幅
    float repWidth = collectionView.frame.size.width;
    //セルの横幅取得
    float cellWidth = cell.frame.size.width;
    
    //ビューにセルが何個置けるか計算これが横表示可能小節数
    int repNum = [self.class kuriageWarizan:(int)repWidth waru:(int)cellWidth];
    
    return repNum;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //ビューにセルが横に何個おけるか
    int repNum = [self.class repNumForCollectionView:collectionView cell:self.cell];
    
    //トラック数
    int track = 2;
    
    //各トラックの中の最大の小節数にあわせる。
    //１Trackの小節数の取得(トラック小節数)
    int trackNum = 100;
        
    //トラック小節数/横表示可能小節数により必要なセクション数を割り出す
    int sectionNum  = [self.class kuriageWarizan:trackNum waru:repNum];
        
    NSLog(@"sectionNum %d",sectionNum);
    
    return sectionNum * track;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //常に一定
    return [self.class repNumForCollectionView:collectionView cell:self.cell];
}

- (NSString *)reuseIdentifer
{
    return @"myCell";
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self reuseIdentifer]
                                                                           forIndexPath:indexPath];
    return cell;
}

@end

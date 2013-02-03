//
//  ViewController.h
//  LayoutCorrectionTest
//
//  Created by katagiri on 2013/01/26.
//  Copyright (c) 2013年 RodhosSoft.Distributed under the MIT license.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <MatrixViewProtocol>
@property (strong, nonatomic) IBOutlet RDMatrixView *matrixView;



@end

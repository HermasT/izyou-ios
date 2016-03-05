//
//  SudoGameView.h
//  izyou
//
//  Created by wudi on 2/10/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SudoGameViewDelegate <NSObject>

- (void)sudoCellTouchUpInside:(UIButton *)sender;

@end

@interface SudoGameView : UIView
- (instancetype)initWithCellWidth:(CGFloat)cellWidth lineNum:(NSInteger)lineNum;

@property(nonatomic,weak)id<SudoGameViewDelegate> delegate;
@end

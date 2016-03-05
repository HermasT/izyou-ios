//
//  SudoGameView.m
//  izyou
//
//  Created by wudi on 2/10/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "SudoGameView.h"

@interface SudoGameView(){
    
}
@property(nonatomic,assign)CGFloat cellWidth;
@property(nonatomic,assign)NSInteger lineNum;

@end
static NSInteger width = 40;

@implementation SudoGameView


- (instancetype)initWithCellWidth:(CGFloat)cellWidth lineNum:(NSInteger)lineNum{
    self = [super initWithFrame:CGRectMake(0, 0, cellWidth*lineNum, cellWidth*lineNum)];
    if (self) {
        self.cellWidth = cellWidth;
        self.lineNum = lineNum;
        [self initSudo];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)initSudo{
    for (int line = 0; line < self.lineNum; line++) {
        for (int row = 0 ; row < self.lineNum; row++) {
            NSInteger i = 255/(self.lineNum * self.lineNum);
            UIButton *cell = [[UIButton alloc] initWithFrame:CGRectMake(line*width,row*width, width, width)];
            cell.backgroundColor = [UIColor colorWithRed:line*row*i/255.f green:line*row*i/255.f blue:line*row*i/255.f alpha:1];
            [cell setTitle:[NSString stringWithFormat:@"%d",line*row] forState:UIControlStateNormal];
            [cell addTarget:self action:@selector(sudoCellTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cell];
        }
    }
    
}

- (void)sudoCellTouchUpInside:(UIButton *)sender{
    if (_delegate && [_delegate performSelector:@selector(sudoCellTouchUpInside:) withObject:sender]) {
        [_delegate sudoCellTouchUpInside:sender];
    }
}
@end

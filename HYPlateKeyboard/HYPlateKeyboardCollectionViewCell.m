//
//  HYPlateKeyboardCollectionViewCell.m
//  HYPlateKeyboard
//
//  Created by axc on 2021/2/25.
//  Copyright © 2021 axc. All rights reserved.
//

#import "HYPlateKeyboardCollectionViewCell.h"

@implementation HYPlateKeyboardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.textLabel];
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.backgroundColor = [UIColor whiteColor];
        _textLabel.layer.cornerRadius = 4;
        _textLabel.layer.masksToBounds = YES;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [UIFont systemFontOfSize:16];
    }
    return _textLabel;
}

@end

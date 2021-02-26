//
//  HYPlateKeyboardView.h
//  HYPlateKeyboard
//
//  Created by axc on 2021/2/25.
//  Copyright © 2021 axc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HYPlateKeyboardViewDataType) {
    HYPlateKeyboardViewDataTypeProvince,           //省
    HYPlateKeyboardViewDataTypeNormal,             //正常
    HYPlateKeyboardViewDataTypeSpecial,            //特殊字
};

@interface HYPlateKeyboardView : UIView

@property (nonatomic, assign) HYPlateKeyboardViewDataType dataType;

@property (nonatomic, copy) void(^completeButtonBlock)(void);

@property (nonatomic, copy) void(^didSelectItemAtIndexPathBlock)(NSString *text);

@end

NS_ASSUME_NONNULL_END

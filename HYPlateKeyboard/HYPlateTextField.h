//
//  HYPlateTextField.h
//  HYPlateKeyboard
//
//  Created by axc on 2021/2/25.
//  Copyright © 2021 axc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HYPlateTextFieldType) {
    HYPlateTextFieldTypeProvince,           //省
    HYPlateTextFieldTypeNormal,             //正常
    HYPlateTextFieldTypeNewEnergy,          //新能源
};

@interface HYPlateTextField : UITextField

@property (nonatomic, assign) HYPlateTextFieldType type;

@property (nonatomic, assign) BOOL selectedStatus;

@property (nonatomic, copy) void(^becameFirstResponderBlock)(HYPlateTextField *textField);

@end

NS_ASSUME_NONNULL_END

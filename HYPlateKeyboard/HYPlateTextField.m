//
//  HYPlateTextField.m
//  HYPlateKeyboard
//
//  Created by axc on 2021/2/25.
//  Copyright © 2021 axc. All rights reserved.
//

#import "HYPlateTextField.h"

#define HYPlateTextFieldBGColor [UIColor colorWithRed:245.0 / 255.0 green:245.0 / 255.0 blue:245.0 / 255.0 alpha:1]
#define HYPlateTextFieldBorderColor [UIColor colorWithRed:0.0 / 255.0 green:122.0 / 255.0 blue:255.0 / 255.0 alpha:1]

#define HYPlateTextFieldCornerRadius 4

@interface HYPlateTextField ()<UITextFieldDelegate>

@end

@implementation HYPlateTextField

- (void)dealloc {
    NSLog(@"dealloc_____%@",self.class);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HYPlateTextFieldBGColor;
        self.layer.cornerRadius = HYPlateTextFieldCornerRadius;
        self.textAlignment = NSTextAlignmentCenter;
        self.tintColor = [UIColor clearColor];
        self.layer.borderColor = HYPlateTextFieldBorderColor.CGColor;
        self.font = [UIFont systemFontOfSize:15];
        
        [self addTarget:self action:@selector(textFieldEditingValueChange:) forControlEvents:UIControlEventEditingChanged];
        self.delegate = self;
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (void)setType:(HYPlateTextFieldType)type {
    _type = type;
    if (type == HYPlateTextFieldTypeProvince) {
        self.placeholder = @"省";
    } else if (type == HYPlateTextFieldTypeNewEnergy) {
        self.placeholder = @"新能源";
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:8], NSForegroundColorAttributeName : [UIColor colorWithRed:90.0 / 255.0 green:90.0 / 255.0 blue:90.0 / 255.0 alpha:1]}];
        self.backgroundColor = [UIColor colorWithRed:232.0 / 255.0 green:250.0 / 255.0 blue:232.0/ 255.0 alpha:1];
    }
}

- (void)setSelectedStatus:(BOOL)selectedStatus {
    _selectedStatus = selectedStatus;
    
    if (selectedStatus) {
        self.layer.borderWidth = 0.5;
    } else {
        self.layer.borderWidth = 0;
    }
}

- (void)textFieldEditingValueChange:(HYPlateTextField *)textField {
    
}

- (void)textFieldDidBeginEditing:(HYPlateTextField *)textField {
    if (self.becameFirstResponderBlock) {
        self.becameFirstResponderBlock(textField);
    }
}

@end

//
//  HYInputPlateView.m
//  HYPlateKeyboard
//
//  Created by axc on 2021/2/25.
//  Copyright © 2021 axc. All rights reserved.
//

#import "HYInputPlateView.h"
#import "HYPlateTextField.h"
#import "HYPlateKeyboardView.h"

#define HYSpace 12
#define HYInputPlateViewBGColor [UIColor whiteColor]

@interface HYInputPlateView ()

@property (nonatomic, strong) UILabel *promptLabel;

@property (nonatomic, strong) HYPlateTextField *selectedTextField;

@property (nonatomic, strong) NSMutableArray <HYPlateTextField *> *textFieldArray;

@property (nonatomic, strong) HYPlateKeyboardView *keyboardView;

@end

@implementation HYInputPlateView

- (void)dealloc {
    NSLog(@"dealloc_____%@",self.class);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HYInputPlateViewBGColor;
        self.textFieldArray = [NSMutableArray new];
        
        [self setupUI];
        [self dealBlock];
    }
    return self;
}

- (NSString *)getPlate {
    NSString *plate = @"";
    for (HYPlateTextField *textField in self.textFieldArray) {
        plate = [NSString stringWithFormat:@"%@%@",plate,textField.text];
    }
    return plate;
}

- (void)setPlate:(NSString *)plate {
    for (int i = 0; i < plate.length; i++) {
        if (i < self.textFieldArray.count) {
            HYPlateTextField *textField = self.textFieldArray[i];
            textField.text = [plate substringWithRange:NSMakeRange(i, 1)];
        }
    }
}

- (void)setupUI {
    [self addSubview:self.promptLabel];
    
    // HYPlateTextField 宽度 高度 origin.y
    CGFloat width = (self.frame.size.width - HYSpace * 9) / 8.0;
    CGFloat height = 44.0;
    CGFloat originY = self.promptLabel.frame.origin.x + self.promptLabel.frame.size.height + HYSpace;
    
    for (int i = 0; i < 8; i++) {
        HYPlateTextField *textField = [[HYPlateTextField alloc] initWithFrame:CGRectMake(HYSpace + (HYSpace + width) * i, originY, width, height)];
        textField.tag = 100 + i;
        textField.inputView = self.keyboardView;
        textField.becameFirstResponderBlock = ^(HYPlateTextField * _Nonnull textField) {
            self.selectedTextField.selectedStatus = NO;
            textField.selectedStatus = YES;
            self.selectedTextField = textField;
            if (textField.tag == 100) {
                if (self.keyboardView.dataType != HYPlateKeyboardViewDataTypeProvince) {
                    self.keyboardView.dataType = HYPlateKeyboardViewDataTypeProvince;
                }
            } else if (textField.tag == 106) {
                if (self.keyboardView.dataType != HYPlateKeyboardViewDataTypeSpecial) {
                    self.keyboardView.dataType = HYPlateKeyboardViewDataTypeSpecial;
                }
            } else {
                if (self.keyboardView.dataType != HYPlateKeyboardViewDataTypeNormal) {
                    self.keyboardView.dataType = HYPlateKeyboardViewDataTypeNormal;
                }
            }
        };
        [self addSubview:textField];
        [self.textFieldArray addObject:textField];
        if (i == 0) {
            textField.type = HYPlateTextFieldTypeProvince;
            [textField becomeFirstResponder];
        } else if (i == 7) {
            textField.type = HYPlateTextFieldTypeNewEnergy;
        }
    }
}

- (void)dealBlock {
    __weak typeof(self) weakSelf = self;
    self.keyboardView.completeButtonBlock = ^{
        [weakSelf endEditing:YES];
        weakSelf.selectedTextField.selectedStatus = NO;
        weakSelf.selectedTextField = nil;
    };
    self.keyboardView.didSelectItemAtIndexPathBlock = ^(NSString * _Nonnull text) {
        if ([text isEqualToString:@"删除"]) {
            if (weakSelf.selectedTextField.text.length > 0) {
                weakSelf.selectedTextField.text = nil;
            } else {
                if (weakSelf.selectedTextField.tag != 100) {
                    HYPlateTextField *textField = weakSelf.textFieldArray[weakSelf.selectedTextField.tag - 1 - 100];
                    [textField becomeFirstResponder];
                    weakSelf.selectedTextField.text = nil;
                }
            }
        } else {
            weakSelf.selectedTextField.text = text;
            if (weakSelf.selectedTextField.tag != 107) {
                HYPlateTextField *textField = weakSelf.textFieldArray[weakSelf.selectedTextField.tag + 1 - 100];
                [textField becomeFirstResponder];
            }
        }
    };
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(HYSpace, HYSpace, self.frame.size.width - HYSpace * 2, 24)];
        _promptLabel.font = [UIFont boldSystemFontOfSize:16];
        _promptLabel.textColor = [UIColor blackColor];
        _promptLabel.text = @"请输入车牌";
    }
    return _promptLabel;
}

- (HYPlateKeyboardView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = [[HYPlateKeyboardView alloc] init];
    }
    return _keyboardView;
}

@end

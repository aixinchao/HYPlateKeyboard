//
//  HYPlateKeyboardView.m
//  HYPlateKeyboard
//
//  Created by axc on 2021/2/25.
//  Copyright © 2021 axc. All rights reserved.
//

#import "HYPlateKeyboardView.h"
#import "HYPlateKeyboardCollectionViewCell.h"

#define HYPlateKeyboardViewBGColor [UIColor colorWithRed:236.0 / 255.0 green:236.0 / 255.0 blue:236.0 / 255.0 alpha:1]
#define HYPlateKeyboardViewHeight 250

@interface HYPlateKeyboardView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *completeButton;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataArrays;

@property (nonatomic, assign) BOOL selected;

@end

@implementation HYPlateKeyboardView

- (void)dealloc {
    NSLog(@"dealloc_____%@",self.class);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = HYPlateKeyboardViewBGColor;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HYPlateKeyboardViewHeight);
        
        self.dataType = HYPlateKeyboardViewDataTypeProvince;
        
        [self setupUI];
    }
    return self;
}

- (void)setDataType:(HYPlateKeyboardViewDataType)dataType {
    _dataType = dataType;
    self.selected = NO;
    if (dataType == HYPlateKeyboardViewDataTypeProvince) {
        self.dataArrays = @[
                            @[@"京",@"津",@"渝",@"沪",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏"],
                            @[@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼"],
                            @[@"川",@"贵",@"云",@"陕",@"甘",@"青",@"蒙",@"桂",@"宁",@"新"],
                            @[@"藏",@"使",@"领",@"警",@"学",@"港",@"澳",@"挂",@"删除"]
                            ];
    } else if (dataType == HYPlateKeyboardViewDataTypeSpecial) {
        self.dataArrays = @[
                            @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"],
                            @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"],
                            @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                            @[@"字",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"删除"]
                            ];
    } else {
        self.dataArrays = @[
                            @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"],
                            @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"],
                            @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                            @[@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"删除"]
                            ];
    }
    [self.collectionView reloadData];
}

- (void)setupUI {
    [self addSubview:self.completeButton];
    [self addSubview:self.collectionView];
}

- (void)completeButtonClick {
    if (self.completeButtonBlock) {
        self.completeButtonBlock();
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArrays.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArrays[section] count];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NSArray *datas = self.dataArrays[section];
    
    CGFloat edgeSpace = 5;
    if (datas.count < 10) {
        edgeSpace = ((self.frame.size.width - 5 * 11) / 10 * (10 - datas.count)) / 2;
    }
    
    return UIEdgeInsetsMake(5, edgeSpace, 0, edgeSpace);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYPlateKeyboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(HYPlateKeyboardCollectionViewCell.class) forIndexPath:indexPath];
    
    NSString *text = self.dataArrays[indexPath.section][indexPath.row];
    cell.textLabel.text = text;
    if (text.length > 1) {
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    } else {
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    if ([text isEqualToString:@"字"]) {
        if (self.selected) {
            cell.textLabel.backgroundColor = [UIColor colorWithRed:0.0 / 255.0 green:122.0 / 255.0 blue:255.0 / 255.0 alpha:1];
            cell.textLabel.textColor = [UIColor whiteColor];
        } else {
            cell.textLabel.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }
    } else {
        cell.textLabel.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HYPlateKeyboardCollectionViewCell *cell = (HYPlateKeyboardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.textLabel.backgroundColor = [UIColor colorWithRed:0.0 / 255.0 green:122.0 / 255.0 blue:255.0 / 255.0 alpha:1];
    cell.textLabel.textColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.25 animations:^{
        cell.textLabel.alpha = 0.9;
    } completion:^(BOOL finished) {
        cell.textLabel.alpha = 1;
        cell.textLabel.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }];
    
    NSString *text = self.dataArrays[indexPath.section][indexPath.row];
    if (![text isEqualToString:@"字"]) {
        if (self.didSelectItemAtIndexPathBlock) {
            self.didSelectItemAtIndexPathBlock(text);
        }
    } else {
        if (!self.selected) {
            self.dataArrays = @[
                                @[@"京",@"津",@"渝",@"沪",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏"],
                                @[@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼"],
                                @[@"川",@"贵",@"云",@"陕",@"甘",@"青",@"蒙",@"桂",@"宁",@"新"],
                                @[@"字",@"藏",@"使",@"领",@"警",@"学",@"港",@"澳",@"挂",@"删除"]
                                ];
        } else {
            self.dataArrays = @[
                                @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"],
                                @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"],
                                @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                                @[@"字",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"删除"]
                                ];
        }
        self.selected = !self.selected;
        [self.collectionView reloadData];
    }
}

- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeButton.frame = CGRectMake(self.frame.size.width - 60, 2.5, 60, 34);
        _completeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completeButton setTitleColor:[UIColor colorWithRed:0.0 / 255.0 green:122.0 / 255.0 blue:255.0 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_completeButton addTarget:self action:@selector(completeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置最小行
        flowLayout.minimumLineSpacing = 0;
        // 最小列间距
        flowLayout.minimumInteritemSpacing = 5;
        /**
        *   设置item的大小 格局item的大小自动布局列间距
        *
        *  @param 50 宽
        *  @param 50 高
        *
        *  @return
        */
        flowLayout.itemSize = CGSizeMake((self.frame.size.width - 5 * 11) / 10, (216 - 5 * 5) / 4);
        //设置集合视图内边距的大小
//        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 34, self.frame.size.width, 216) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:HYPlateKeyboardCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(HYPlateKeyboardCollectionViewCell.class)];
    }
    return _collectionView;
}

@end

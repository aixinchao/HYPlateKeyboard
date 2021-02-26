//
//  AppDelegate.h
//  HYPlateKeyboard
//
//  Created by axc on 2021/2/25.
//  Copyright © 2021 axc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


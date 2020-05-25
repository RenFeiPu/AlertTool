//
//  AlertTools.h
//  111
//
//  Created by Apple on 2020/5/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertTools : NSObject

#pragma mark alert提示框
+ (void)showAlertTitle:(NSString *)title msg:(NSString *)msg cancleTitle:(NSString *)cancleTitle cancleAction:(void(^)(void))cancleAction actionTitle:(NSString *)actionTitle action:(void(^)(void))action;

+ (void)showNoticeTitle:(NSString *)title msg:(NSString *)msg actionTitle:(NSString *)actionTitle action:(void (^)(void))action;

#pragma mark actionSheet提示
+ (void)showAlertSheetTitles:(NSArray *)titles clickIndex:(void (^)(NSInteger index))click;

#pragma mark 列表选择
+ (void)showSelectViewTitle:(NSString *)title contents:(NSArray *)contents action:(void (^)(NSInteger index))action;

@end

NS_ASSUME_NONNULL_END

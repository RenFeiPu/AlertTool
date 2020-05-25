//
//  AlertTools.m
//  111
//
//  Created by Apple on 2020/5/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "AlertTools.h"
#import <LEEAlert.h>
#import "AlertSelectView.h"

@interface AlertTools ()

@property (copy, nonatomic) void (^cancleAction)(void);
@property (copy, nonatomic) void (^action)(void);
@property (copy, nonatomic) void (^actionSheet)(NSInteger index);

@end

@implementation AlertTools

#define kUIColor(hex,alph) [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0 green:((hex >> 8) & 0xFF)/255.0 blue:(hex & 0xFF)/255.0 alpha:alph]

#pragma mark alert提示框
+ (void)showAlertTitle:(NSString *)title msg:(NSString *)msg cancleTitle:(NSString *)cancleTitle cancleAction:(void (^)(void))cancleAction actionTitle:(NSString *)actionTitle action:(void (^)(void))action{
    
    AlertTools *alert = [AlertTools new];
    alert.cancleAction = cancleAction;
    alert.action = action;
    
    [LEEAlert alert]
    .config
    .LeeTitle(title)
    .LeeAddContent(^(UILabel * _Nonnull label) {
        label.text = msg;
        label.font = [UIFont systemFontOfSize:15];
    })
    .LeeAddAction(^(LEEAction* action){
        action.title = cancleTitle;
        action.titleColor = [UIColor systemGrayColor];
        action.font = [UIFont systemFontOfSize:16];
        action.clickBlock = ^{
            [alert cancleClick];
        };
    })
    .LeeAddAction(^(LEEAction* action){
        action.title = actionTitle;
        action.titleColor = [UIColor systemRedColor];
        action.font = [UIFont boldSystemFontOfSize:16];
        action.clickBlock = ^{
            [alert action];
        };
    })
    .LeeShow();
}

+ (void)showNoticeTitle:(NSString *)title msg:(NSString *)msg actionTitle:(NSString *)actionTitle action:(void (^)(void))action{
    
    AlertTools *alert = [AlertTools new];
    alert.action = action;
    
    [LEEAlert alert]
    .config
    .LeeTitle(title)
    .LeeAddContent(^(UILabel * _Nonnull label) {
        label.text = msg;
        label.font = [UIFont systemFontOfSize:15];
    })
    .LeeAddAction(^(LEEAction *action){
        action.title = actionTitle;
        action.font = [UIFont systemFontOfSize:16];
        action.titleColor = [UIColor systemGrayColor];
        action.clickBlock = ^{
            [alert click];
        };
    })
    .LeeShow();
}

- (void)cancleClick{
    
    if (self.cancleAction) {
        self.cancleAction();
    }
}

- (void)click{
    
    if (self.action) {
        self.action();
    }
}

#pragma mark actionSheet提示
+ (void)showAlertSheetTitles:(NSArray *)titles clickIndex:(void (^)(NSInteger))click{
    
    AlertTools *alert = [AlertTools new];
    alert.actionSheet = click;
    LEEActionSheetConfig *config = [LEEAlert actionsheet];
    LEEBaseConfigModel *model = config.config;
    
    for (NSInteger i=0; i<titles.count; i++) {
        model.LeeAddAction(^(LEEAction *action) {
            NSString *title = titles[i];
            if (title && title.length) {
                   action.title = title;
                   action.backgroundColor = [UIColor whiteColor];
                   action.font = [UIFont systemFontOfSize:16];
                   action.titleColor = kUIColor(0x333333, 1);
                   action.clickBlock = ^{
                        [alert actionWithIndex:i];
                     };
            }else{
                action.title = @" ";
                action.titleColor = kUIColor(0x333333, 1);
                action.backgroundColor = kUIColor(0xf5f5f5, 1);
                action.height = 10;
            }
        });
    }
//    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
        model.LeeCornerRadius(0)
        // 设置取消按钮间隔的颜色
        .LeeActionSheetCancelActionSpaceColor([UIColor systemPinkColor])
        .LeeActionSheetCancelActionSpaceWidth(10)
        .LeeActionSheetBottomMargin(0.0f)
        .LeeActionSheetHeaderCornerRadii(CornerRadiiMake(10, 10, 0, 0))
        .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
               // 这是最大宽度为屏幕宽度 (横屏和竖屏)
               return type == LEEScreenOrientationTypeHorizontal ? CGRectGetHeight([[UIScreen mainScreen] bounds]) : CGRectGetWidth([[UIScreen mainScreen] bounds]);
           })
        .LeeShow();
//    });
}

- (void)actionWithIndex:(NSInteger)index{
    
    self.actionSheet(index);
}

#pragma mark 列表选择
+ (void)showSelectViewTitle:(NSString *)title contents:(NSArray *)contents action:(void (^)(NSInteger index))action{
    
    AlertTools *alert = [AlertTools new];
    alert.actionSheet = action;
    AlertSelectView *view = [[AlertSelectView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-50, 50*contents.count) style:UITableViewStylePlain];
    view.selectedBlock = ^(NSInteger index) {
        [LEEAlert closeWithCompletionBlock:^{
            [alert actionWithIndex:index];
        }];
    };
    [LEEAlert alert]
    .config
    .LeeTitle(title)
    .LeeItemInsets(UIEdgeInsetsMake(10, 0, 10, 0))
    .LeeCustomView(view)
//    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    #ifdef __IPHONE_13_0
    .LeeUserInterfaceStyle(UIUserInterfaceStyleLight)
    #endif
    .LeeShow();
    view.contents = contents;
}

@end

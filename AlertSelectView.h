//
//  AlertSelectView.h
//  111
//
//  Created by Apple on 2020/5/21.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertSelectView : UITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

@property (copy, nonatomic) NSArray *contents;

@property (nonatomic , copy ) void (^selectedBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END

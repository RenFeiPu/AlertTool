//
//  AlertSelectView.m
//  111
//
//  Created by Apple on 2020/5/21.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "AlertSelectView.h"
#import "ListViewCell.h"

@interface AlertSelectView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AlertSelectView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
//        self.allowsMultipleSelectionDuringEditing = YES; //支持同时选中多行
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        self.separatorColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
        self.tableFooterView = [UIView new];
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([ListViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    }return self;
}

- (void)setContents:(NSArray *)contents{
    
    _contents = contents;
    [self reloadData];
}

#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.contents.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentLabel.text = self.contents[indexPath.row];
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.selectedBlock(indexPath.row);
}

@end

//
//  ChatCell.h
//  ParseChat
//
//  Created by atalwar98 on 7/10/19.
//  Copyright © 2019 atalwar98. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatUser;

@end

NS_ASSUME_NONNULL_END

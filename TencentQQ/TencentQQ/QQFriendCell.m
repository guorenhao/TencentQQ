//
//  QQFriendCell.m
//  TencentQQ
//
//  Created by 郭人豪 on 2016/12/3.
//  Copyright © 2016年 Abner_G. All rights reserved.
//

#import "QQFriendCell.h"

@interface QQFriendCell ()

@property (nonatomic, strong) UIImageView * image_icon;
@property (nonatomic, strong) UILabel * lab_nickname;
@property (nonatomic, strong) UILabel * lab_signature;
@end
@implementation QQFriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self addSubviews];
    }
    return self;
}

#pragma mark - add subviews

- (void)addSubviews {
    
    [self addSubview:self.image_icon];
    [self addSubview:self.lab_nickname];
    [self addSubview:self.lab_signature];
}

#pragma mark - layout subviews

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_image_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(@15);
        make.top.mas_equalTo(@10);
    }];
    
    [_lab_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_image_icon.mas_top);
        make.left.mas_equalTo(_image_icon.mas_right).with.offset(15);
        make.right.mas_equalTo(@-15);
        make.height.mas_equalTo(@21);
    }];
    
    [_lab_signature mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_image_icon.mas_bottom);
        make.left.mas_equalTo(_lab_nickname.mas_left);
        make.right.mas_equalTo(_lab_nickname.mas_right);
        make.height.mas_equalTo(@21);
    }];
}

#pragma mark - config cell

- (void)configCellWithData:(NSDictionary *)dic row:(NSInteger)row {
    
    _image_icon.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    _lab_nickname.text = [NSString stringWithFormat:@"好友%lu", row + 1];
    _lab_signature.text = [NSString stringWithFormat:@"这是好友%lu的签名", row + 1];
}

#pragma mark - setter and getter

- (UIImageView *)image_icon {
    
    if (!_image_icon) {
        
        _image_icon = [[UIImageView alloc] init];
        _image_icon.contentMode = UIViewContentModeScaleAspectFill;
        _image_icon.layer.cornerRadius = 25.0;
        _image_icon.layer.masksToBounds = YES;
    }
    return _image_icon;
}

- (UILabel *)lab_nickname {
    
    if (!_lab_nickname) {
        
        _lab_nickname = [[UILabel alloc] init];
        _lab_nickname.font = [UIFont systemFontOfSize:18];
    }
    return _lab_nickname;
}

- (UILabel *)lab_signature {
    
    if (!_lab_signature) {
        
        _lab_signature = [[UILabel alloc] init];
        _lab_signature.font = [UIFont systemFontOfSize:12];
    }
    return _lab_signature;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

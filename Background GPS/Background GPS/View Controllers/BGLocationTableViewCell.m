//
//  BGLocationTableViewCell.m
//  Background GPS
//
//  Created by Andrey Zhdanov on 06/03/14.
//  Copyright (c) 2014 Andrey Zhdanov. All rights reserved.
//

#import "BGLocationTableViewCell.h"

@implementation BGLocationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

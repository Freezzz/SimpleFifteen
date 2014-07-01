//
//  FFNumberCell.m
//  fifteens
//
//  Created by Ivan Litsvinenka on 01/07/14.
//  Copyright (c) 2014 net.freezzz. All rights reserved.
//

#import "FFNumberCell.h"
@interface FFNumberCell ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end;

@implementation FFNumberCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)configureForPosition:(NSNumber *)position {
    // Case when position is 0 - empty slot
    if (position.intValue == 0) {
        self.backgroundColor = [UIColor clearColor];
        self.numberLabel.text = @"";
    } else {
        self.numberLabel.text = [NSString stringWithFormat:@"%@", position];
        self.backgroundColor = [UIColor greenColor];
    }
}
@end

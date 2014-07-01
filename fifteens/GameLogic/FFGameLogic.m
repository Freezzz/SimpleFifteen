//
//  FFGameLogic.m
//  fifteens
//
//  Created by Ivan Litsvinenka on 01/07/14.
//  Copyright (c) 2014 net.freezzz. All rights reserved.
//

#import "FFGameLogic.h"
@interface FFGameLogic ()
@property (strong, nonatomic, readwrite) NSMutableArray * deck;
@property (assign, nonatomic) NSInteger rowSize;

- (NSInteger)nextPositionForCellAtPath:(NSUInteger)path;
- (BOOL)victoryConditionMatched;
@end

@implementation FFGameLogic

- (instancetype)initWithCellCount:(NSUInteger)cellCount {
    if (self = [super init]) {
        self.deck = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < cellCount; i++) {
            [self.deck addObject:@(i)];
        }
        
        self.rowSize = (NSInteger) roundf(sqrt(cellCount));

    }
    return  self;
}

#pragma mark - Utility methods
- (void)shuffleDeck {
    NSUInteger count = self.deck.count;
    for (NSUInteger i = 0; i < count; ++i) {
        
        // Randomize index to swap with
        NSInteger shuffledIndex = arc4random_uniform(count);
        [self.deck exchangeObjectAtIndex:i withObjectAtIndex:shuffledIndex];
    }
}

#pragma mark - Victory conditions
- (BOOL)victoryConditionMatched {
    NSNumber * prevNumber = self.deck[0];
    for (NSUInteger i = 1; i < self.deck.count - 1; i++) {
        
        // Cells value shoulb lower than previous
        NSNumber * currentNumber = self.deck[i];
        if (prevNumber.intValue > currentNumber.intValue) {
            return NO;
        }
        prevNumber = currentNumber;
    }
    return YES;
}

#pragma mark - Movement
- (NSInteger)moveCellAtIndex:(NSUInteger)index {
    if (index >= self.deck.count ) {
        return  -1;
    }
    
    NSInteger nextIndex = [self nextPositionForCellAtPath:index];
    if (nextIndex != -1) {
        [self.deck exchangeObjectAtIndex:index withObjectAtIndex:nextIndex];
        
        // Validate victory condition
        if ([self victoryConditionMatched] && self.victoryBlock) {
            self.victoryBlock();
        }
    }
    
    return nextIndex;
}

- (NSInteger)nextPositionForCellAtPath:(NSUInteger)path {
    // Since we have AxA field we can siplify neighbor calculation
    NSInteger leftCellIndex = path - 1;
    NSInteger rightCellIndex = path + 1;
    NSInteger topCellIndex = path - self.rowSize;
    NSInteger botCellIndex = path + self.rowSize;
    
    if (leftCellIndex >= 0 && [self.deck[leftCellIndex]  isEqual: @(0)]) {
        return leftCellIndex;
    }
    
    if (rightCellIndex < self.deck.count && [self.deck[rightCellIndex] isEqual: @(0)]) {
        return rightCellIndex;
    }
    
    if (topCellIndex >= 0 && [self.deck[topCellIndex] isEqual: @(0)]) {
        return topCellIndex;
    }
    
    if (botCellIndex < self.deck.count && [self.deck[botCellIndex] isEqual: @(0)]) {
        return botCellIndex;
    }
    return -1;
}
@end

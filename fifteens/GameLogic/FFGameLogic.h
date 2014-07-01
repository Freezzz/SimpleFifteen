//
//  FFGameLogic.h
//  fifteens
//
//  Created by Ivan Litsvinenka on 01/07/14.
//  Copyright (c) 2014 net.freezzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFGameLogic : NSObject
@property (strong, nonatomic, readonly) NSMutableArray * deck; // DataModel contaier
@property (nonatomic, copy) void (^victoryBlock)(void); // Block to be callded on win conditions


/** Dedicated initializer with custom number of cells
 
 @param positionCount  count of cells in game, game is intended for AxA filed so number should be power of 2
 */
- (instancetype)initWithCellCount:(NSUInteger)cellCount;


/** Tries to move cell in adjacent positions
 
 @param index index of the cell to move
 @return new index of cell if the move was possible, -1 otherwise
 */
- (NSInteger)moveCellAtIndex:(NSUInteger)index;

/** Shuffles cells in deck
 */
- (void)shuffleDeck;
@end

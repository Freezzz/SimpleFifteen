//
//  FFGameLogicTest.m
//  fifteens
//
//  Created by Ivan Litsvinenka on 01/07/14.
//  Copyright (c) 2014 net.freezzz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FFGameLogic.h"
@interface FFGameLogicTest : XCTestCase
@property (strong, nonatomic) FFGameLogic * gameLogic;
@end

@implementation FFGameLogicTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.gameLogic = [[FFGameLogic alloc] initWithCellCount:9];
}

- (void)tearDown {
    self.gameLogic = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialization {
    NSUInteger count = 16;
    FFGameLogic * gameLogicLocal = [[FFGameLogic alloc] initWithCellCount:count];
    XCTAssertNotNil(gameLogicLocal);
    XCTAssertTrue(gameLogicLocal.deck.count == count, @"Initialized count does not match initial value");
}

- (void)testMovement {
    // We have:
    // 1 2 3
    // 4 5 6
    // 7 8 0
    NSMutableArray * referenceDeck = [self.gameLogic.deck mutableCopy];
    
    // Move 8 to 0
    XCTAssertTrue([self.gameLogic moveCellAtIndex:7] == 8, @"Cell 1 should move to position 0");
    [referenceDeck exchangeObjectAtIndex:7 withObjectAtIndex:8];
    
    XCTAssertTrue([self.gameLogic.deck isEqualToArray:referenceDeck], @"Cell 1 was not moved");
    
    // We have:
    // 1 2 3
    // 4 5 6
    // 7 8 0
    // Try to move 1
    XCTAssertTrue([self.gameLogic moveCellAtIndex:1] == -1, @"-1 is exped as sign of not moving");
    XCTAssertTrue([self.gameLogic.deck isEqualToArray:referenceDeck], @"Cell 1 should not move");
    
    
    XCTAssertTrue([self.gameLogic moveCellAtIndex:499] == -1, @"-1 when value is out of range");
}

- (void)testShuffleDeck {
    NSMutableArray * referenceDeck = [self.gameLogic.deck mutableCopy];
    [self.gameLogic shuffleDeck];
    
    XCTAssertFalse([self.gameLogic.deck isEqualToArray:referenceDeck], @"Suffled deck should be different from initial one");
}
@end

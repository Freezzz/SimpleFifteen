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
    // 0 1 2
    // 3 4 5
    // 6 7 8
    NSMutableArray * referenceDeck = [self.gameLogic.deck mutableCopy];
    
    // Move 1 to 0
    XCTAssertTrue([self.gameLogic moveCellAtIndex:1] == 0, @"Cell 1 should move to position 0");
    [referenceDeck exchangeObjectAtIndex:0 withObjectAtIndex:1];
    
    XCTAssertTrue([self.gameLogic.deck isEqualToArray:referenceDeck], @"Cell 1 was not moved");
    
    // We have:
    // 1 0 2
    // 3 4 5
    // 6 7 8
    // Try to move 8
    XCTAssertTrue([self.gameLogic moveCellAtIndex:8] == -1, @"-1 is exped as sign of not moving");
    XCTAssertTrue([self.gameLogic.deck isEqualToArray:referenceDeck], @"Cell 8 should not move");
    
    
    XCTAssertTrue([self.gameLogic moveCellAtIndex:499] == -1, @"-1 when value is out of range");
}

- (void)testShuffleDeck {
    NSMutableArray * referenceDeck = [self.gameLogic.deck mutableCopy];
    [self.gameLogic shuffleDeck];
    
    XCTAssertFalse([self.gameLogic.deck isEqualToArray:referenceDeck], @"Suffled deck should be different from initial one");
}
@end

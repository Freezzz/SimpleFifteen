//
//  FFViewController.m
//  fifteens
//
//  Created by Ivan Litsvinenka on 01/07/14.
//  Copyright (c) 2014 net.freezzz. All rights reserved.
//

#import "FFViewController.h"
#import "FFNumberCell.h"

#import "FFGameLogic.h"

@interface FFViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) FFGameLogic * gameLogic;

- (IBAction)onShuffleButton:(id)sender;
@end

@implementation FFViewController


#pragma mark - UIViewController Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.gameLogic = [[FFGameLogic alloc] initWithCellCount:16];
    
    __weak FFViewController * wself = self;
    self.gameLogic.victoryBlock = ^() {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
                                                         message:@"You have beaten the game!"
                                                        delegate:wself
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"Replay", nil];
        [alert show];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIControls
- (IBAction)onShuffleButton:(id)sender {
    [self.gameLogic shuffleDeck];
    [self.collectionView reloadData];
}


#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.gameLogic.deck.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber * number = self.gameLogic.deck[indexPath.row];
    
    FFNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NumberCell" forIndexPath:indexPath];
    [cell configureForPosition:number];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger position = [self.gameLogic moveCellAtIndex:indexPath.row];
    
    if (position != -1) {
        NSIndexPath * toIndexPath = [NSIndexPath indexPathForItem:position inSection:0];
        
        [self.collectionView performBatchUpdates:^{
            [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:toIndexPath];
            [self.collectionView moveItemAtIndexPath:toIndexPath toIndexPath:indexPath];
        } completion:^(BOOL finished) {
            if (finished) {
                [self.collectionView reloadData];
            }
        }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.gameLogic shuffleDeck];
    [self.collectionView reloadData];
}
@end

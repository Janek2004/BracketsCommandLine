//
//  Game.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/22/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "Game.h"

@implementation Game
-(NSArray *)getChildrenNodes;{
    NSMutableArray * array = [NSMutableArray new];
    if(self.right){
        [array addObject:self.right];
    }

    if(self.left){
        [array addObject:self.left];
    }
    
    return array;
}

-(NSString *)description{
  id l=  [self.left gameId];
  id r=  [self.right gameId];
    
    return [NSString stringWithFormat:@" \n Game Id %@ \n Number: %@ \n Children:%@ %@ \n Team 1 %@ Team 2 %@",self.gameId, self.number, l, r,self.team1, self.team2];
    
    
}

@end

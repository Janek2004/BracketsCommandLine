//
//  Team.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "Team.h"
#import "Stats.h"
#import "Game.h"

@interface Team()
    @property(nonatomic,strong)Stats * stats;
@end


@implementation Team


-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}



//players
-(void)addPlayer:(id)player;{}
-(void)removePlayer:(id)player;{}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@ %@",self.seed, self.name];
}
@end

//
//  Team.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSNumber * seed;
//players
-(void)addPlayer:(id)player;
-(void)removePlayer:(id)player;

@end

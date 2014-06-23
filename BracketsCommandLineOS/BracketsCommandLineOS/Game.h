//
//  Game.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/22/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Game : NSObject

@property (nonatomic,strong) id team1;
@property (nonatomic,strong) id team2;
@property (nonatomic,strong) id left;
@property (nonatomic,strong) id right;


@property (nonatomic,strong) NSDate * date;
@property (nonatomic, assign) BOOL finished;///? if it has score is finished if it's not it's not.
@property (nonatomic, strong) id winner;
@property (nonatomic,strong) NSNumber* team1Score;
@property (nonatomic,strong) NSNumber* team2Score;

//set winner
//ser score
//set date
//set time and so on


@end

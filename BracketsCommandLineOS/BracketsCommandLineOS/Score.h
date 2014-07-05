//
//  Score.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/4/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject
    @property(nonatomic,strong) NSMutableArray * sets;
    //Set 1:  21:15
    //Set 2:  16:21
    //Set 3   15:17

    /*
       //set/game?
       array of dictionaries?
     
       Dictionary?
        team1Score: NSNumber
        team2Score: NSNumber
        team1: id
        team2: id
     
     Set1:   Score 21:15
     */

-(void)setScore:(id)score1 andScore:(id)score2 betweenTeam:(id)team1 andTeam2:(id)team2;



@end

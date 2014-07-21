//
//  DoubleElimination.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "DoubleElimination.h"
#import "SingleElimination.h"
/**
 This variation of the tournament will have two nodes of tournament
  * winners - winners will have original number of teams let's say n
  * losers - will have half of the teams 
 
  How do we deal with buys
 
 Winners:
  a-
    1 a-
  b-     2-a
      c-
                Final: a -b
 
  Losers
   b-----
          3-b
        c-
 
 
 http://www.aropupu.fi/bracket/
 
 */


@interface DoubleElimination()

 @property (nonatomic,strong) id finalGame;
 @property(nonatomic,strong) SingleElimination * winners;
 @property(nonatomic,strong) SingleElimination * losers;
@end

@implementation DoubleElimination
 //Steps to acccomplish
 //get the final losers game.
 //Calculate number of games on given level
/*
                                                        Final Game
                                     Loser of final round -1 Winner of previous round of losers game
                                                    
 Loser of final round -2 Winner of Winner of previous round of bracket of losers game   Loser of final round -2 Winner of Winner of previous round of bracket of losers game
 
 
 Traverse level by level
 find number of losers
 Distribute losers over the losers bracket
 If losers count %2 != 0 -> loser with highest seed will get a buy, it will happen only on lower levels though
 
 
 
 */




@end

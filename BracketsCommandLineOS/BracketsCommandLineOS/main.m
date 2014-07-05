//
//  main.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tournament.h"
#import "Game.h"
#import "Stats.h"


int main(int argc, const char * argv[])
{
    @autoreleasepool {
        Tournament * t = [[Tournament alloc]init ];
        [t addTeam:@"Janek / Taylor"];
        [t addTeam:@"Keith/Megan "];
        [t addTeam:@"Charlie/Chelsea"];
        [t addTeam:@"Eric/Meghan"];
        [t addTeam:@"Jack/Michelle"];
        [t addTeam:@"Ian/Patchi"];
        [t addTeam:@"Mallory/Zack"];
        [t addTeam:@"Whitney/Adrian "];

        Game * g = [Game new];
        g.number =@4;
        Game * result = [t searchForGame: g];
        NSLog(@"Result %@",result);
        
        //t recursiveAddScore:<#(id)#> search:<#(id)#>
        
//        [t addTeam:@"Charlie/Chelsea"];
//        [t addTeam:@"Charlie/Chelsea"];
//        [t addTeam:@"Charlie/Chelsea"];
        
        
   //     [t addTeam:@"Keith/Megan "];
   //     [t addTeam:@"Charlie/Chelsea"];
     
     
   //     NSMutableArray * array =[@[@1,@2,@3,@4,@5,@6,@7] mutableCopy];
        //take first n elements
        
        
      // sortArr(array,1);
       // int i =0;
       // int j = array.count-1;
        
       
        //NSLog(@"%@",array);
        
        
        
    // [t addTeam:@"Charlie/Chelsea"];
    // [t addTeam:@"Charlie/Chelsea"];
        
     // Team * team = [Team new]
     //   Tournament * t1 = [[Tournament alloc]initWithNumberOfTeams:4];
     //   Tournament * t2 = [[Tournament alloc]initWithNumberOfTeams:8];
        
     //NSLog(@"Maximum Number of Games in Level:  %lu",(unsigned long)[t maxNumberOfGamesInLevelForTeams:9]);
        
      /*
       NSLog(@"%d", [t numberOfGamesForTeamsNumber:3 andMode:kSingleElimination]);
        NSLog(@"%d", [t numberOfGamesForTeamsNumber:4 andMode:kSingleElimination]);
        NSLog(@"%d", [t numberOfGamesForTeamsNumber:8 andMode:kSingleElimination]);
        NSLog(@"%d", [t numberOfGamesForTeamsNumber:12 andMode:kSingleElimination]);
        NSLog(@"%d", [t numberOfGamesForTeamsNumber:16 andMode:kSingleElimination]);
        */
        
        
        
    }
    return 0;
}


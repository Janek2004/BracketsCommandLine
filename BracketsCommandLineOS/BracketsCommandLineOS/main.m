//
//  main.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tournament.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        Tournament * t = [[Tournament alloc]init ]; 
        [t addTeam:@"Janek / Taylor"];
        [t addTeam:@"Keith/Megan "];
        [t addTeam:@"Charlie/Chelsea"];
        [t addTeam:@"Eric/Megan"];
        
        
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


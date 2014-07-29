//
//  SingleElimination.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//
#import "Game.h"
#import "Team.h"
#import "SingleElimination.h"
#import "TournamentUtilities.h"
#import "Score.h"

@interface SingleElimination()

 @property (nonatomic,assign)  NSUInteger numberOfFirstRoundGames;
 @property (nonatomic,strong)  NSMutableArray * teams;
 @property (nonatomic,strong)  TournamentUtilities * utilities;
@end

@implementation SingleElimination

-(instancetype)init{
    if(self = [super init]){
         self.utilities = [TournamentUtilities new];
         self.teams = [NSMutableArray new];
    }
    return self;
}

-(void)setTournamentTeams:(id)teams;{
    [self.teams removeAllObjects];
    [self.teams addObjectsFromArray:teams];
    [self buildBracketWithTeams:self.teams];
}


-(void)buildBracketWithTeams:(NSArray *)teams
{
    self.root = NULL;
     
    _numberOfGames = [self numberOfGamesForTeamsNumber:teams.count];
    _numberOfTeams = teams.count;
    
    for (int i=0; i<self.numberOfGames; i++) {
        [self addGameWithId:i];
    }
    
    [self buildBracket];
}

-(NSUInteger)getNumberOfGamesForLevel{
    
    
    
    return 0;
}



/**Adding game to game tree using breadth depth search */
-(void)addGameWithId:(int)gameId{
    NSMutableArray * queue=[NSMutableArray new];
    if(!self.root){
        Game * game = [Game new];
        game.gameId = [NSNumber numberWithInt:gameId];
        
        self.root = game;
        [queue addObject:game];
        return;
    }
    
    [queue addObject:self.root];
    
    while(queue.count>0){
        Game * root =  queue.lastObject;
        //remove
        [queue removeObject:root];
        if(root.left == NULL){
            Game * game = [Game new];
            game.gameId = [NSNumber numberWithInt:gameId];
            root.left  = game;
            [game setParent:root];
            return;
        }
        else if(root.right == NULL){
            Game * game = [Game new];
            game.gameId = [NSNumber numberWithInt:gameId];
            root.right = game;
            [game setParent:root];
            return;
        }
        else{
            NSArray * a = [root getChildrenNodes];
            for(Game * child in a){
                [queue insertObject:child atIndex:0];
            }
        }
    }
}

-(NSUInteger)numberOfGamesForTeamsNumber:(NSUInteger)teamsNumber{
    //calculate round 1
    NSUInteger closestPower =[self findClosestPower:teamsNumber];
    //NSLog(@"Closest Power %lu",(unsigned long)closestPower);
    NSUInteger gameCount = pow(2, closestPower);
    
    NSUInteger numberOfGamesInFirstRound = [self findNumberOfFirstRoundGames:gameCount andTeamsNumber:teamsNumber];
    
    NSUInteger num = gameCount/2;
    while (num/2>=1)
    {
        num = num/2;
        numberOfGamesInFirstRound+=num;
    }
    
    return numberOfGamesInFirstRound;
}

//Calculates maximum number of games in one level
-(NSUInteger)maxNumberOfGamesInLevelForTeams:(int)numberOfTeams{
    NSUInteger
    power = [self findClosestPower:numberOfTeams];
    return pow(2, power-1);
}


-(NSUInteger)findClosestPower:(NSUInteger)teams{
    NSUInteger k =1;
    NSUInteger power =0;
    while(k<teams){
        k = k*2;
        power++;
    }
    
    return power;
}

-(NSUInteger)findNumberOfLevelsForTeams:(NSUInteger)teamsNumber{
    [self findClosestPower:teamsNumber];
    
    return 0;
}

-(NSUInteger)findNumberOfFirstRoundGames:(NSUInteger)gameCount andTeamsNumber:(NSUInteger)teamsNumber{
    NSUInteger difference =gameCount - teamsNumber;
    NSUInteger k = gameCount/2.0 - difference;
    self.numberOfFirstRoundGames = k;
    
    return _numberOfFirstRoundGames;
}

-(id)getTournamentSchedule;{
    NSMutableArray * games =[NSMutableArray new];
    if(!self.root)return nil;
    NSMutableArray * queue= [NSMutableArray new];
    // NSMutableArray * visited= [NSMutableArray new];
    
    [queue addObject:self.root];
    
    while(queue.count>0){
        Game * g= queue.lastObject;
        [queue removeLastObject];
        if(g.team1!=NULL &&g.team2!=NULL){
            [games addObject:g];
        }
        
        NSArray *nodes =   g.getChildrenNodes;
        for(Game * child in nodes){
            //add to queue
            [queue insertObject:child atIndex:0];
        }
    }
    
    
    [games sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]]];
    
    
    return games;
}



-(void)buildBracket;{
    if(self.numberOfGames==0){
        NSLog(@"Not enough Games");
        return;
    }
    
    if(!self.root) return;
    
    NSMutableArray * queue = [NSMutableArray new];
    NSMutableArray * _visited = [NSMutableArray new];
    
    [queue addObject:self.root];
    [_visited addObject:self.root];
    
    NSUInteger nodesInCurrentLevel = 1;
    NSUInteger nodesInNextLevel = 0;
    NSUInteger currentLevel = 1;
    NSUInteger maxLevel = [self findClosestPower:self.teams.count];
    
    NSUInteger firstLevelGames =[self findNumberOfFirstRoundGames:pow(2,  maxLevel) andTeamsNumber:self.teams.count];
    
    NSUInteger maxNumberOfGamesInFirstLevel =  pow(2, maxLevel-1);
    
    NSUInteger difference =  maxNumberOfGamesInFirstLevel - firstLevelGames;
    
    //the difference will have to be distributed in level maxLevel-1
    [self.utilities sortArray:self.teams andStart:0 end:difference];
    [self.utilities sortArray:self.teams andStart:difference end:self.teams.count];
    
   
    //get number of games;
    NSUInteger gn = self.numberOfGames;
    
    NSUInteger level1diff = difference;
    NSUInteger level2diff=  difference;
    
    while (queue.count >0) {
        
        Game * game =queue.lastObject;
        game.number = [NSNumber numberWithInteger:gn];
        gn--;
        //remove from queue
        [queue removeLastObject];
        nodesInCurrentLevel--;

        //Special cases one level from up from the last level
        if(currentLevel == maxLevel-1){
            //if it has both children than we leave it alone.
            //if it has only one children we assign values from array starting from the left to right
            if(game.left == NULL){
                game.team1 = self.teams[level2diff-1];
                level2diff--;
            }
            if(game.right == NULL){
                game.team2 = self.teams[level2diff-1];
                level2diff--;
            }
        }
        
        if(currentLevel == maxLevel){
            Team * team1 = self.teams[level1diff];
            Team * team2 = self.teams[++level1diff];
            game.team1 =team1;
            game.team2 =team2;
            
            level1diff++;
        }
        
        for(Game* child in [game getChildrenNodes]){
            if(![_visited containsObject:child])
            {
                [_visited addObject:child];
                [queue insertObject:child atIndex:0];
                nodesInNextLevel++;
            }
        }
        
        //tracking current level after processing all nodes from current level
        if(nodesInCurrentLevel == 0){
            nodesInCurrentLevel = nodesInNextLevel;
            nodesInNextLevel = 0;
            currentLevel++;
            
        }
    }
}

-(void)buildDoubleEliminationBracket;{
    if(self.numberOfGames==0){
        NSLog(@"Not enough Games");
        return;
    }
    
    if(!self.root) return;
    
    NSMutableArray * queue = [NSMutableArray new];
    NSMutableArray * _visited = [NSMutableArray new];
    
    [queue addObject:self.root];
    [_visited addObject:self.root];
    
    NSUInteger nodesInCurrentLevel = 1;
    NSUInteger nodesInNextLevel = 0;
    NSUInteger currentLevel = 1;
    NSUInteger maxLevel = [self findClosestPower:self.teams.count];
    
    NSUInteger firstLevelGames =[self findNumberOfFirstRoundGames:pow(2,  maxLevel) andTeamsNumber:self.teams.count];
    
    NSUInteger maxNumberOfGamesInFirstLevel =  pow(2, maxLevel-1);
    
    NSUInteger difference =  maxNumberOfGamesInFirstLevel - firstLevelGames;
    
    //the difference will have to be distributed in level maxLevel-1
    [self.utilities sortArray:self.teams andStart:0 end:difference];
    [self.utilities sortArray:self.teams andStart:difference end:self.teams.count];
    
    
    //get number of games;
    NSUInteger gn = self.numberOfGames;
    
    NSUInteger level1diff = difference;
    NSUInteger level2diff=  difference;
    
    while (queue.count >0) {
        
        Game * game =queue.lastObject;
        game.number = [NSNumber numberWithInteger:gn];
        gn--;
        //remove from queue
        [queue removeLastObject];
        nodesInCurrentLevel--;
        
        //Special cases one level from up from the last level
        if(currentLevel == maxLevel-1){
            //if it has both children than we leave it alone.
            //if it has only one children we assign values from array starting from the left to right
            if(game.left == NULL){
                game.team1 = self.teams[level2diff-1];
                level2diff--;
            }
            if(game.right == NULL){
                game.team2 = self.teams[level2diff-1];
                level2diff--;
            }
        }
        
        if(currentLevel == maxLevel){
            Team * team1 = self.teams[level1diff];
            Team * team2 = self.teams[++level1diff];
            game.team1 =team1;
            game.team2 =team2;
            
            level1diff++;
        }
        
        for(Game* child in [game getChildrenNodes]){
            if(![_visited containsObject:child])
            {
                [_visited addObject:child];
                [queue insertObject:child atIndex:0];
                nodesInNextLevel++;
            }
        }
        
        //tracking current level after processing all nodes from current level
        if(nodesInCurrentLevel == 0){
            nodesInCurrentLevel = nodesInNextLevel;
            nodesInNextLevel = 0;
            currentLevel++;
            
        }
    }
}



-(void)updateStats{
    
    //for each game
    //check the score
    NSMutableDictionary * stats =[NSMutableDictionary new];
    if(!self.root)return;
    NSMutableArray * queue= [NSMutableArray new];
    
    [queue addObject:self.root];
    
    while(queue.count>0){
        Game * g= queue.lastObject;
        [queue removeLastObject];
        
        if(g.team1){
            //Resetting stats
            if(![stats objectForKey:[g.team1 gameSeed]]){
                [g.team1 resetStats];
                [stats setObject:g forKey:[g.team1 gameSeed]];
            }
            [g.team1 updateStatsWithScore:g.score];
            
        }
        
        if(g.team2) {
            if(![stats objectForKey:g.team2]){
                [g.team2 resetStats];
                [stats setObject:g forKey:[g.team2 gameSeed]];
            }
            [g.team2 updateStatsWithScore:g.score];
        }
        
        NSArray *nodes =   g.getChildrenNodes;
        for(Game * child in nodes){
            //add to queue
            [queue insertObject:child atIndex:0];
        }
    }
}

-(void)setScore:(id)score game:(id)game{
    Game * foundGame = [self searchForGame:game];
    foundGame.score = score;
    Team * winner = [score getWinner];
    
    if(winner){
        //get parent
        Game * parentGame = foundGame.parent;
        if(parentGame.left == foundGame){
            parentGame.team1 =winner;
        }
        if(parentGame.right == foundGame){
            parentGame.team2 =winner;
        }
    }
    
    //update team stats
    [self updateStats];
    [self.utilities getTeamsInOrder:self.teams];
}

-(id)searchForGame:(id)game;{
    return [self recursiveSearch:self.root search:game];
}

-(Game *)recursiveSearch:(Game *)game search:(Game *)element{
    if(game!=NULL){
        if([game.number isEqual:element.number]){
            return game;
        }
        
        Game * foundNode = [self recursiveSearch:game.left search:element];
        if(foundNode == NULL){
            foundNode = [self recursiveSearch:game.right search:element];
        }
        return foundNode;
    }
    else{
        return NULL;
    }
}

-(id)getTeamsInOrder;{
    
    return  [self.utilities getTeamsInOrder:self.teams];
}


@end

//
//  Tournament.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//
/**
 Tournament
    Games
        Teams
            Players
 
 
Node is a game:
 with paramaters:
 finished
 array:
    team a
    team b
 team a result
 team b result
 winner: id
 date NSDate
 
 //traverse

 http://stackoverflow.com/questions/22859730/generate-a-single-elimination-tournament
*/

#import "Tournament.h"
#import "Game.h"
#import "Team.h"

@interface Tournament()
{

}
   // @property (nonatomic,strong)NSMutableArray * games;
    @property (nonatomic,strong)NSMutableArray * teams;
    @property (nonatomic,strong)NSMutableArray * players;
    @property (nonatomic,strong)Game * root; // it will be actually last game

    @property NSUInteger numberOfGames;
    @property NSUInteger numberOfLevels;
    @property NSUInteger numberOfTeams;
    @property NSUInteger numberOfFirstRoundGames;

@end


@implementation Tournament

-(instancetype)init{
    if(self = [ super init]){
      //  _games   = [NSMutableArray new];
        _teams   = [NSMutableArray new];
        _players = [NSMutableArray new];
    }
    return self;
}



-(void)buildBracketWithTeams:(NSArray *)teams
{
    self.root = NULL;
    self.numberOfGames = [self numberOfGamesForTeamsNumber:teams.count andMode:kSingleElimination];
    self.numberOfTeams = teams.count;
    
    for (int i=0; i<self.numberOfGames; i++) {
        [self addGameWithId:i];
    }
}


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
            return;
        }
        
        else if(root.right == NULL){
            Game * game = [Game new];
            game.gameId = [NSNumber numberWithInt:gameId];
            root.right = game;
            return;
        }
        else{
            //both of nodes are taken time to remove it from the queue
            //and add children to the queue for further examination
            NSArray * a = [root getChildrenNodes];
            for(Game * child in a){
                [queue insertObject:child atIndex:0];
            }
        }
    }
}

-(void)setTournamentMode:(TournamentMode)tournamentMode{
    _tournamentMode = tournamentMode;
}


-(instancetype)initWithNumberOfTeams:(int)numberofteams{
    self = [self init];
   
    
  // [self buildBracketWithTeams:<#(NSArray *)#>]
    
    
    return self;
}



-(void)displayBracket;{
    if(self.numberOfGames==0){
        NSLog(@"Not enough Games");
        return;
    }

    NSLog(@"_________________________________________");
    
    if(!self.root) return;
    
    NSMutableArray * queue = [NSMutableArray new];
    NSMutableArray * visited = [NSMutableArray new];
    
    [queue addObject:self.root];
    [visited addObject:self.root];

    NSUInteger nodesInCurrentLevel = 1;
    NSUInteger nodesInNextLevel = 0;
    NSUInteger currentLevel = 1;
    NSUInteger maxLevel = [self findClosestPower:self.teams.count];
   
    NSUInteger firstLevelGames =[self findNumberOfFirstRoundGames:pow(2,  maxLevel) andTeamsNumber:self.teams.count];

    NSUInteger maxNumberOfGamesInFirstLevel =  pow(2, maxLevel-1);
  //  NSLog(@"%lu %lu %s",firstLevelGames,maxNumberOfGamesInFirstLevel,__PRETTY_FUNCTION__);
    
    NSUInteger difference =  maxNumberOfGamesInFirstLevel - firstLevelGames;
    //the difference will have to be distributed in level maxLevel-1
    [self sortArray:self.teams andStart:0 end:difference];
    [self sortArray:self.teams andStart:difference end:self.teams.count];

    NSLog(@"Sorted Array %@",self.teams);
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

       
        
        //here we can look for some kind of data
        if(currentLevel == maxLevel-1){
           // NSLog(@"here we need populate the difference ");
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
            if(![visited containsObject:child])
            {
                [visited addObject:child];
                [queue insertObject:child atIndex:0];
                 nodesInNextLevel++;
            }
        }

        if(nodesInCurrentLevel == 0){
            nodesInCurrentLevel = nodesInNextLevel;
            nodesInNextLevel = 0;
            currentLevel++;
            NSLog(@"\n");
        }
        
         NSLog(@"Game: %@", game);
        
    }
    NSLog(@"_________________________________________");
}


-(NSArray *) sortArray:(NSMutableArray *) array andStart: (NSUInteger) start end: (NSUInteger) end{
    NSUInteger length = array.count;
    NSUInteger j = end -1;
    if(end == 0)
    {
        j=0;
    }
    for(NSUInteger i =start; i<length; i++)
    {
        if(i>=j){
            break;
        }
        id secondObject = array[i+1];
       
        //take last element
        id lastObject = array[j];
        array[j] = secondObject;
        array[i+1] = lastObject;
        
        //decrement j
        if(j>=2){
            j=j-2;
        }
        else{
            break;
        }
        i =i+1;
    }
    return array;
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

-(NSUInteger)numberOfGamesForTeamsNumber:(NSUInteger)teamsNumber andMode:(TournamentMode)mode;{
    //calculate round 1
    NSUInteger closestPower =[self findClosestPower:teamsNumber];
    NSLog(@"Closest Power %lu",(unsigned long)closestPower);
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

-(void)addTeam:(NSString *)teamName{
    Team * team = [Team new];
    team.name = teamName;
    
    //reset bracket
    [self.teams addObject:team];
    int i =1;
    for(id team in self.teams){
        [team setSeed:[NSNumber numberWithInt:i]];
        i++;
    }
    
    [self buildBracketWithTeams:self.teams];
    
    //recalculate bracket
    [self displayBracket];
}



//add score
-(void)addScoreForGame:(id)gameId winner:(id)team score1:(id)scoreTeam1 score2:(id)scoreTeam2;{
//find a game with particular id
    NSMutableArray * queue = [NSMutableArray new];
    NSMutableArray * visited = [NSMutableArray new];
    
    [queue addObject:self.root];
    [visited addObject:self.root];
    
    while(queue.count>0){
        //get last object
        Game * g = queue.lastObject;
        if([g.gameId isEqual:@([gameId intValue] )])
        {
           //set score
            
            return;
        }
        
        
        
        
    }

}
@end

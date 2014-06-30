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
    self.numberOfGames = [self numberOfGamesForTeamsNumber:teams.count andMode:kSingleElimination];
    self.numberOfTeams = teams.count;
    
    for (int i=0; i<self.numberOfGames; i++) {
        [self alternateAdditionWithId:i];
    }
    
   // [self displayBracket];
}

//-(void)addGameWithId:(int)gameId{
//   
//    if(!self.root){
//        Game * game = [Game new];
//        game.gameId = [NSNumber numberWithInt:gameId];
//        
//        self.root = game;
//        [_games addObject:game];
//        return;
//    }
//   
//    
//    if(self.root) {
//        Game * game = _games.firstObject;
//        Game * gl = [Game new];
//        gl.gameId = [NSNumber numberWithInt:gameId];
//        [_games addObject:gl];
//        
//        if(game.left == NULL){
//            //create a new game
//            game.left = gl;
//            
//        }
//        else if(game.right == NULL){
//            game.right = gl;
//        }
//        
//        if(game.left != NULL && game.right != NULL){
//            [_games removeObject:game];
//            
//            return;
//        }
//    }
//}


-(void)alternateAdditionWithId:(int)gameId{
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
    
    //get number of games;
    NSUInteger gn = self.numberOfGames;
    
    while (queue.count >0) {
        
        Game * game =queue.lastObject;
        game.number = [NSNumber numberWithInteger:gn];
        gn--;
        //remove from queue
        [queue removeLastObject];
        nodesInCurrentLevel--;

        NSLog(@"Game nr: %@", game.number);
        
        //here we can look for some kind of data
        for(Game* child in [game getChildrenNodes]){
            //NSLog(@"____Child %@",child);
            if(![visited containsObject:child])
            {
                [visited addObject:child];
                [queue insertObject:child atIndex:0];
            }
            nodesInNextLevel++;
        }

        if(nodesInCurrentLevel == 0){
            nodesInCurrentLevel = nodesInNextLevel;
            NSLog(@"\n");
        }
    }
    NSLog(@"_________________________________________");
}


//Calculates maximum number of games in one level
-(NSUInteger)maxNumberOfGamesInLevelForTeams:(int)numberOfTeams{
    NSUInteger
    power = [self findClosestPower:numberOfTeams];
    return pow(2, power-1);
}


-(void)addPlayer:(id)player;{

}

-(void)removePlayer:(id)player;{

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

-(NSUInteger)numberOfGamesForTeamsNumber:(NSUInteger)teamsNumber andMode:(TournamentMode)mode;{
    //calculate round 1
    NSUInteger closestPower =[self findClosestPower:teamsNumber];
    // NSLog(@"Closest Power %d",closestPower);
    NSUInteger gameCount = pow(2, closestPower);
    NSUInteger difference =gameCount - teamsNumber;
    NSUInteger k = gameCount/2.0 - difference;
    // NSLog(@"Number of games in first round is: %d",k);
    NSUInteger num = gameCount/2;
    while (num/2>=1)
    {
        num = num/2;
        k+=num;
    }
    
    NSLog(@"Total number of games is: %lu",(unsigned long)k);
    return k;
}

-(void)addTeam:(NSString *)teamName{
    Team * team = [Team new];
    team.name = teamName;

    [self.teams addObject:team];
    [self buildBracketWithTeams:self.teams];
    
    //recalculate bracket
    [self displayBracket];
}

-(void)removeTeam:(id)team;{

}

-(void)addScore:(id)team1 andTeam2:(id)team2 winner:(id)team score1:(id)team1score score2:(id)team2score{
    
}








@end

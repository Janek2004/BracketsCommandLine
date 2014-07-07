
//  Tournament.m
//  BracketsCommandLineOS

//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
// http://stackoverflow.com/questions/22859730/generate-a-single-elimination-tournament

#import "Tournament.h"
#import "Game.h"
#import "Team.h"
#import "Score.h"

@interface Tournament()
    @property (nonatomic,strong)NSMutableArray * teams;
    @property (nonatomic,strong)NSMutableArray * winningTeams;
    @property (nonatomic,strong)NSMutableArray * losingTeams;
    @property (nonatomic,strong)NSMutableArray * players;
    @property (nonatomic,strong)Game * root; // modified binary tree

    @property NSUInteger numberOfGames;
    @property NSUInteger numberOfLevels;
    @property NSUInteger numberOfTeams;
    @property NSUInteger numberOfFirstRoundGames;
    @property (nonatomic,strong) NSString *  tournamentId;


@end


@implementation Tournament
/**
 *  Default init method
 *
 *  @return instance of the tournament class
 */
-(instancetype)init{
    if(self = [ super init]){
        _teams   = [NSMutableArray new];
        _players = [NSMutableArray new];
        _winningTeams = [NSMutableArray new];
        _losingTeams = [NSMutableArray new];
        _tournamentId = [[NSUUID UUID]UUIDString];
        
    }
    return self;
}

#pragma mark public methods
-(NSUInteger)getTotalNumberOfTeams;{
    return self.numberOfTeams;
}


-(NSUInteger)getNumberOfGames{
    return self.numberOfGames;
}

-(NSString *)getTournamentId;{
    return _tournamentId;
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
    

    [games sortUsingDescriptors:@[  [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]]];
    
    
    return games;
}


-(void)buildBracketFor:(TournamentMode)mode;{
    
    switch (mode) {
        case kSingleElimination:
            [self buildBracketWithTeams:self.teams];
            break;
        case kDoubleElimination:
            
            break;
        case kRoundRobin:
            
            break;
            
        default:
            break;
    }
}

-(void)buildBracketWithTeams:(NSArray *)teams
{
    self.root = NULL;
    self.numberOfGames = [self numberOfGamesForTeamsNumber:teams.count andMode:kSingleElimination];
    self.numberOfTeams = teams.count;
    
   // NSLog(@" %lu",self.numberOfGames );
    for (int i=0; i<self.numberOfGames; i++) {
        [self addGameWithId:i];
    }
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
/** Tournament Mode */
-(void)setTournamentMode:(TournamentMode)tournamentMode{
    _tournamentMode = tournamentMode;
}


-(instancetype)initWithNumberOfTeams:(int)numberofteams{
    self = [self init];
   
    
    
    
    return self;
}



-(void)displayBracket;{
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
    [self sortArray:self.teams andStart:0 end:difference];
    [self sortArray:self.teams andStart:difference end:self.teams.count];

   // NSLog(@"Sorted Array %@",self.teams);
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
            if(![_visited containsObject:child])
            {
                [_visited addObject:child];
                [queue insertObject:child atIndex:0];
                 nodesInNextLevel++;
            }
        }

        if(nodesInCurrentLevel == 0){
            nodesInCurrentLevel = nodesInNextLevel;
            nodesInNextLevel = 0;
            currentLevel++;

        }
    }
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

-(void)removeTeam:(id)team{
    [self.teams removeObject:team];
    
    [self.teams enumerateObjectsUsingBlock:^(Team * team, NSUInteger idx, BOOL *stop) {
         [team setSeed:[NSNumber numberWithInteger:idx]];
    }];

    [self buildBracketWithTeams:self.teams];
}


/**
 Methods for setting score for the game
*/
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
}

-(void)updateStats{
    
    //for each game
    //check the score
    NSMutableDictionary * stats =[NSMutableDictionary new];
    if(!self.root)return;
    NSMutableArray * queue= [NSMutableArray new];
   // NSMutableArray * visited= [NSMutableArray new];
    
    [queue addObject:self.root];

    while(queue.count>0){
     Game * g= queue.lastObject;
     [queue removeLastObject];
      
        if(g.team1){
        //Resetting stats
            if(![stats objectForKey:[g.team1 seed]]){
                [g.team1 resetStats];
                [stats setObject:g forKey:[g.team1 seed]];
            }
            [g.team1 updateStatsWithScore:g.score];
            
        }
        
        if(g.team2) {
            if(![stats objectForKey:g.team2]){
                [g.team2 resetStats];
                [stats setObject:g forKey:[g.team2 seed]];
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



-(id)getStatsForTeam:(id)team{
    if([self.teams containsObject:team]){
        return [team stats];
    }
    
    return NULL;
}



#pragma mark utilities

/**Sorting teams */
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

/***/
-(id)getTeamsInOrder;{
//    self.teams sort
   // [self.teams sortUsingSelector:@selector(compare:)];
    ///return self.teams;

    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"stats" ascending:NO];
    [self.teams sortUsingDescriptors:@[sort]];
    
    
    return self.teams;
}


@end

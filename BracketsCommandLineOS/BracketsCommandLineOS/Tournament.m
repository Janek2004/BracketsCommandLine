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
 

 
 
a-
        a-
b-             - // winner

c-
     c-
d-      e-
     e-
 */
#import "Tournament.h"
#import "Game.h"
@interface Tournament()
    @property (nonatomic,strong)NSMutableArray * games;
    @property (nonatomic,strong)NSMutableArray * teams;
    @property (nonatomic,strong)NSMutableArray * players;
    @property (nonatomic,strong)Game * root; // it will be actually last game


@end


@implementation Tournament

-(instancetype)init{
    if(self = [ super init]){
        _games   = [NSMutableArray new];
        _teams   = [NSMutableArray new];
        _players = [NSMutableArray new];
    }
    return self;
}


-(Game*)buildBracket:(NSArray *)games start:(int)start end: (int)end{
    if(start>end){
        return NULL;
    }
    int mid = (end + start) /2;
    Game * g= [games objectAtIndex:mid];
    g.left =[self buildBracket:games start:0 end:mid-1];
    g.right=[self buildBracket:games start:mid+1 end:end];
    return g;
}

-(Game *)buildBracket{
    Game * game =[self buildBracket:self.games start:0 end:(int)self.games.count-1];
    
    return game;
}



-(void)addGame{
    Game * game = [Game new];
    [_games addObject:game];
    if(!self.root){
        self.root = game;
    }
    //traverse
    /*
     
     BinaryTree* sortedArrayToBST(int arr[], int start, int end) {
     if (start > end) return NULL;
     // same as (start+end)/2, avoids overflow.
     int mid = start + (end - start) / 2;
     BinaryTree *node = new BinaryTree(arr[mid]);
     node->left = sortedArrayToBST(arr, start, mid-1);
     node->right = sortedArrayToBST(arr, mid+1, end);
     return node;
     }
     
     BinaryTree* sortedArrayToBST(int arr[], int n) {
     return sortedArrayToBST(arr, 0, n-1);
     }
     */
}


-(void)addGame:(id)_game;{

    
    
}




-(void)removeGame:(id)team;{

}



-(void)setTournamentMode:(TournamentMode)tournamentMode{
    _tournamentMode = tournamentMode;
}



-(void)initWithNumberOfTeams:(int)numberofteams{

}



-(void)displayBracket;{
    if(self.teams.count==0){
        NSLog(@"Not enough teams");
        return;
    }
    
  Game * game = [self buildBracket];
    while(game.team1){
        game = game.team1;
        NSLog(@" Left ");
    
    }
    
    
    
    
    
}

-(void)addPlayer:(id)player;{

}

-(void)removePlayer:(id)player;{

}

-(void)addTeam:(id)team;{
     [self.teams addObject:team];
    
    if(self.games.count >1){
        //add game
        [self addGame];
    }
    //recalculate bracket
    [self displayBracket];
}

-(void)removeTeam:(id)team;{

}

-(void)addScore:(id)team1 andTeam2:(id)team2 winner:(id)team score1:(id)team1score score2:(id)team2score{
    
}





@end

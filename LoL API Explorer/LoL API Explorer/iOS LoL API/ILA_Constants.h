//
//  Constants.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#ifndef LoL_API_Explorer_Constants_h
#define LoL_API_Explorer_Constants_h

typedef NS_ENUM(long, queueTypes) {
    CUSTOM = 0,
    NORMAL_5x5_BLIND = 2,
    BOT_5x5 = 7,
    BOT_5x5_INTRO = 31,
    BOT_5x5_BEGINNER = 32,
    BOT_5x5_INTERMEDIATE = 33,
    NORMAL_3x3 = 8,
    NORMAL_5x5_DRAFT = 14,
    ODIN_5x5_BLIND = 16,
    ODIN_5x5_DRAFT = 17,
    BOT_ODIN_5x5 = 25,
    RANKED_SOLO_5x5 = 4,
    RANKED_PREMADE_3x3 = 9,
    RANKED_PREMADE_5x5 = 6,
    RANKED_TEAM_3x3 = 41,
    RANKED_TEAM_5x5 = 42,
    BOT_TT_3x3 = 52,
    GROUP_FINDER_5x5 = 61,
    ARAM_5x5 = 65,
    ONEFORALL_5x5 = 70,
    FIRSTBLOOD_1x1 = 72,
    FIRSTBLOOD_2x2 = 73,
    SR_6x6 = 75,
    URF_5x5 = 76,
    BOT_URF_5x5 = 83,
    NIGHTMARE_BOT_5x5_RANK1 = 91,
    NIGHTMARE_BOT_5x5_RANK2 = 92,
    NIGHTMARE_BOT_5x5_RANK5 = 93,
    ASCENSION_5x5 = 96,
    HEXAKILL = 98,
    KING_PORO_5x5 = 300,
    COUNTER_PICK = 310,
};

typedef NS_ENUM(NSInteger, gameTypes) {
    CUSTOM_GAME,
    TUTORIAL_GAME,
    MATCHED_GAME,
};

#endif
//
//  Person.m
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 21/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize ID;
@synthesize name;
@synthesize activity;
@synthesize sector;
@synthesize country;

-(id)initPerson
{
    if (self==[super init])
    {
        
    }
    
    return self;
}

-(id)initPerson:(NSString *)aName activity:(NSString *)aActivity sector:(NSString *)aSector country:(NSString *)aCountry id:(NSNumber *)aId {
    if (self = [super init]) {
        ID = aId;
        name = aName;
        activity = aActivity;
        sector = aSector;
        country = aCountry;    }
    return self;
}

+(id)personWithModel:(NSString *)aName activity:(NSString *)aActivity sector:(NSString *)aSector country:(NSString *)aCountry id:(NSNumber *)aId{
    
    return [[self alloc] initPerson:aName activity:aActivity sector:aSector country:aCountry id:aId];
}

@end

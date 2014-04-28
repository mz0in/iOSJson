//
//  Person.h
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 21/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *activity;
@property (nonatomic, strong) NSString *sector;
@property (nonatomic, strong) NSString *country;

-(id)initPerson;
+(id)personWithModel:(NSString *)aName activity:(NSString *)aActivity sector:(NSString *)aSector country:(NSString *)aCountry id:(NSNumber *)aId;

@end

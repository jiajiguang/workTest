//
//  ZYBaseClass.m
//
//  Created by   on 15/4/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZYBaseClass.h"
#import "ZYData.h"


NSString *const kZYBaseClassMessage = @"message";
NSString *const kZYBaseClassData = @"data";


@interface ZYBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZYBaseClass

@synthesize message = _message;
@synthesize data = _data;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:kZYBaseClassMessage fromDictionary:dict];
            self.data = [ZYData modelObjectWithDictionary:[dict objectForKey:kZYBaseClassData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kZYBaseClassMessage];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZYBaseClassData];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.message = [aDecoder decodeObjectForKey:kZYBaseClassMessage];
    self.data = [aDecoder decodeObjectForKey:kZYBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kZYBaseClassMessage];
    [aCoder encodeObject:_data forKey:kZYBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZYBaseClass *copy = [[ZYBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end

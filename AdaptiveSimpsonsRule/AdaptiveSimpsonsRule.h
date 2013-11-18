//
//  AdaptiveSimpsonsRule.h
//  AdaptiveSimpsonsRule
//
//  Created by Blake Merryman on 11/17/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdaptiveSimpsonsRule : NSObject
@property(nonatomic)NSNumber* ptA;
@property(nonatomic)NSNumber* ptB;
@property(nonatomic)NSNumber* eps;
@property(nonatomic)NSNumber* result;
-(id)init;
-(id)initWithStart:(NSNumber*)ptA End:(NSNumber*)ptB AndEpsilon:(NSNumber*)eps;
-(id)recursiveAdaptiveSimpsonsRule;
-(NSNumber*)theFunction;
-(NSNumber*)simpsonsRule;
@end

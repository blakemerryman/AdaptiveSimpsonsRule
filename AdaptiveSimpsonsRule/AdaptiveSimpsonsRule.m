//
//  AdaptiveSimpsonsRule.m
//  AdaptiveSimpsonsRule
//
//  Created by Blake Merryman on 11/17/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import "AdaptiveSimpsonsRule.h"

#pragma mark - Private Interface Declarations:
@interface AdaptiveSimpsonsRule ()
-(id)recursiveAdaptiveSimpsonsRule;             // Recursive-adaptive logic method.
-(NSNumber*)simpsonsRuleStart:(NSNumber*)pt1
                       Finish:(NSNumber*)pt2;   // Simpson's Rule.
-(NSNumber*)theFunctionAtAPoint:(NSNumber*)pt;  // The function being approximated by ASR.
@end

@implementation AdaptiveSimpsonsRule
#pragma mark - Public Method Implementations:
-(id)init
{
    
}

-(id)initWithStart:(NSNumber*)ptA
               End:(NSNumber*)ptB
        AndEpsilon:(NSNumber*)eps
{
    
}

-(NSNumber*)evaluateAdaptiveSimpsonsMethod
{
    
}

#pragma mark - Private Method Implementations:
-(id)recursiveAdaptiveSimpsonsRule
{
    
}

-(NSNumber*)simpsonsRuleStart:(NSNumber*)pt1
                       Finish:(NSNumber*)pt2
{
    
    NSNumber* midPoint = [NSNumber numberWithDouble: ([pt1 doubleValue] + [pt2 doubleValue]) / 2.0];
    
    NSNumber* hOver3 = [NSNumber numberWithDouble: fabs([pt2 doubleValue] - [pt2 doubleValue]) / 6.0];
    
    NSNumber* functAtPnt1 = [self theFunctionAtAPoint:[NSNumber numberWithDouble:[pt1 doubleValue]]];
    
    NSNumber* functAtMdPt = [self theFunctionAtAPoint:[NSNumber numberWithDouble:[midPoint doubleValue]]];
    
    NSNumber* functAtPnt2 = [self theFunctionAtAPoint:[NSNumber numberWithDouble:[pt2 doubleValue]]];
    
    NSNumber* approximation = [NSNumber numberWithDouble:hOver3*([functAtPnt1 doubleValue]+4.0*[functAtMdPt doubleValue]+[functAtPnt2 doubleValue])];
    
    return approximation;
}

-(NSNumber*)theFunctionAtAPoint:(NSNumber*)pt
{
    // Manually coded function definition.
    double functionValue = sin([pt doubleValue]);
    
    // Returns the function value at point.
    return [NSNumber numberWithDouble:functionValue];
}

@end

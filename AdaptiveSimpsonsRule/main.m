//
//  main.m
//  AdaptiveSimpsonsRule
//
//  Created by Blake Merryman on 11/17/13.
//  Copyright (c) 2013 Blake Merryman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdaptiveSimpsonsRule.h"



int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        NSNumber* pointA = [NSNumber numberWithDouble: 0.0  ];
        NSNumber* pointB = [NSNumber numberWithDouble: M_PI ];
        NSNumber* error  = [NSNumber numberWithDouble: 1 * pow(10, -10) ];
        
        AdaptiveSimpsonsRule* ASR = [[AdaptiveSimpsonsRule alloc] initWithPtA:pointA
                                                                      WithPtB:pointB
                                                                   AndEpsilon:error];
        
        NSNumber* approximation = [ASR approximateUsingAdaptiveSimpsonsRule];
        NSLog(@"Approximation of f(x) is %f.",[approximation doubleValue]);
        
    }
    return 0;
}


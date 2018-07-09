//
//  GlobalVariable.m
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "GlobalVariable.h"

@implementation GlobalVariable
@synthesize ImageBase64, Email, DATA, haveEcash;

static GlobalVariable *instance = nil;

+ (GlobalVariable *)sharedInstance {
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [GlobalVariable new];
        }
    }
    return instance;
}

@end

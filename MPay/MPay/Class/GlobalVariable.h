//
//  GlobalVariable.h
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariable : NSObject
{
    NSMutableDictionary *DATA;
    NSString *ImageBase64;
    NSString *Email;
    NSString *haveEcash;
}

@property(nonatomic, retain) NSMutableDictionary *DATA;
@property(nonatomic, retain) NSString *ImageBase64;
@property(nonatomic, retain) NSString *Email;
@property(nonatomic, retain) NSString *haveEcash;

+ (GlobalVariable *)sharedInstance;

@end

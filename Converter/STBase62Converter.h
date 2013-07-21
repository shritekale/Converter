//
//  STBase62Converter.h
//  Converter
//
//  Created by Shri on 21/07/13.
//  Copyright (c) 2013 Shri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STBase62Converter : NSObject {
    
}

@property (nonatomic, strong) NSMutableArray *baseArray;

-(NSString *) getBase62FromDecimal:(long long) number;
-(long long) getDecimalFromBase62:(NSString *) number;
@end

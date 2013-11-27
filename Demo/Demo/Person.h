//
//  Person.h
//  demo
//
//  Created by 库颖 on 13-11-27.
//  Copyright (c) 2013年 库颖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSNumber * age;

@end

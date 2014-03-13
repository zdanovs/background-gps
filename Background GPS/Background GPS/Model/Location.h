//
//  Location.h
//  Background GPS
//
//  Created by Andrey Zhdanov on 11/03/14.
//  Copyright (c) 2014 Andrey Zhdanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Location : NSManagedObject

@property (nonatomic, retain) NSDate    *timestamp;
@property (nonatomic, retain) NSNumber  *latitude;
@property (nonatomic, retain) NSNumber  *longitude;

@end

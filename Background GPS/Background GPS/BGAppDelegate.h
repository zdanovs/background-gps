//
//  BGAppDelegate.h
//  Background GPS
//
//  Created by Andrey Zhdanov on 06/03/14.
//  Copyright (c) 2014 Andrey Zhdanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel         *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext       *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

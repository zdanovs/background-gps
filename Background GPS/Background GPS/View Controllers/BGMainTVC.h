//
//  BGMainTVC.h
//  Background GPS
//
//  Created by Andrey Zhdanov on 06/03/14.
//  Copyright (c) 2014 Andrey Zhdanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface BGMainTVC : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@end

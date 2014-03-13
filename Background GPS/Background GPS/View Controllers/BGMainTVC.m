//
//  BGMainTVC.m
//  Background GPS
//
//  Created by Andrey Zhdanov on 06/03/14.
//  Copyright (c) 2014 Andrey Zhdanov. All rights reserved.
//

#define kLocationCellIdentifier @"LocationCell"
#define kLocationEntityName     @"Location"
#define kTimeAttributeName      @"timestamp"

#import "BGAppDelegate.h"
#import "BGMainTVC.h"
#import "Location.h"


@interface BGMainTVC () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray    *locations;

@end

@implementation BGMainTVC

@synthesize managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BGAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    [self populateSavedLocations];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 50.0f;
    self.locationManager.delegate = self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLocationCellIdentifier forIndexPath:indexPath];
    
    Location *location = self.locations[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%f, %f", location.latitude.floatValue, location.longitude.floatValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm dd/MM/YYYY"];
    cell.detailTextLabel.text = [formatter stringFromDate:location.timestamp];
    
    return cell;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    Location *location = (Location *)[NSEntityDescription insertNewObjectForEntityForName:kLocationEntityName
                                                                   inManagedObjectContext:managedObjectContext];
    
    location.timestamp = newLocation.timestamp;
    location.longitude = [NSNumber numberWithFloat:newLocation.coordinate.longitude];
    location.latitude  = [NSNumber numberWithFloat:newLocation.coordinate.latitude];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Error in adding a new location %@, %@", error, [error userInfo]);
        abort();
    } else {
        [self.locations insertObject:location atIndex:0];
    }
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive) {
        [self.tableView reloadData];
    } else {
        NSLog(@"App is backgrounded. New location is %@", newLocation);
    }
}

#pragma mark - IBActions methods

- (IBAction)enabledStateChanged:(id)sender {
    UISwitch *switcher = (UISwitch *)sender;
    
    if (switcher.on) {
        [self.locationManager startUpdatingLocation];
    }
    else {
        [self.locationManager stopUpdatingLocation];
    }
}

- (IBAction)clearAllButtonTapped:(id)sender {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:kLocationEntityName inManagedObjectContext:self.managedObjectContext]];
    [fetchRequest setIncludesPropertyValues:NO];
    
    NSArray *receivedLocations = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    for (NSManagedObject *location in receivedLocations) {
        [self.managedObjectContext deleteObject:location];
    }
    
    [self.managedObjectContext save:nil];
    [self.locations removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - Additional methods

- (void)populateSavedLocations {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:kTimeAttributeName ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kLocationEntityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    self.locations = fetchedObjects.mutableCopy;
}

@end

//
//  DemoAppDelegate.m
//  demo
//
//  Created by 库颖 on 13-11-20.
//  Copyright (c) 2013年 库颖. All rights reserved.
//

#import "DemoAppDelegate.h"

#import "Person.h"

// support core data
@interface DemoAppDelegate ()

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end


@implementation DemoAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL) createNewPersonWithFirstName:(NSString *)paramFirstName lastName:(NSString *)paramLastName
                                  age:(NSUInteger)paramAge{
    BOOL result = NO;
    if ([paramFirstName length] == 0 || [paramLastName length] == 0){
        NSLog(@"First and Last names are mandatory."); return NO;
    }
    Person *newPerson = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Person"
                         inManagedObjectContext:self.managedObjectContext];
    if (newPerson == nil){
        NSLog(@"Failed to create the new person."); return NO;
    }
    newPerson.firstname = paramFirstName;
    newPerson.lastname = paramLastName;
    newPerson.age = @(paramAge);
    NSError *savingError = nil;
    if ([self.managedObjectContext save:&savingError]){ return YES;
    }else{
        NSLog(@"Failed to save the new person. Error = %@", savingError);
    }
    return result;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // create
    [self createNewPersonWithFirstName:@"Steve"
                              lastName:@"Jobs"
                                   age:51];
    [self createNewPersonWithFirstName:@"Richard"
                              lastName:@"Branson"
                                   age:61];
    
    // read
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]
                                    initWithEntityName:@"Person"];
    NSError *requestError = nil;
    /* And execute the fetch request on the context */
    NSArray *persons =
    [self.managedObjectContext executeFetchRequest:fetchRequest
                                             error:&requestError];
    /* Make sure we get the array */
     if ([persons count] > 0){
         /* Go through the persons array one by one */
         NSUInteger counter = 1;
         for (Person *thisPerson in persons){
             NSLog(@"Person %lu First Name = %@", (unsigned long)counter,
                   thisPerson.firstname);
             NSLog(@"Person %lu Last Name = %@", (unsigned long)counter,
                   thisPerson.lastname);
             NSLog(@"Person %lu Age = %ld", (unsigned long)counter,
                   (unsigned long)[thisPerson.age unsignedIntegerValue]); counter++;
         }
         
     }else{
         NSLog(@"Could not find any Person entities in the context.");
     }
    
    // delete last one
    if ([persons count] > 0){
        /* Delete the last person in the array */
        Person *lastPerson = [persons lastObject];
        [self.managedObjectContext deleteObject:lastPerson];
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]){
            NSLog(@"Successfully deleted the last person in the array."); }
        else{
                NSLog(@"Failed to delete the last person in the array.");
            }
    }else{
        NSLog(@"Could not find any Person entities in the context.");
    }
    
    // sort
    NSFetchRequest *sortFetchRequest = [[NSFetchRequest alloc]
                                    initWithEntityName:@"Person"];
    NSSortDescriptor *ageSort =
    [[NSSortDescriptor alloc] initWithKey:@"age"
                                ascending:YES];
    NSSortDescriptor *firstNameSort =
    [[NSSortDescriptor alloc] initWithKey:@"firstname"
                                ascending:YES];
    sortFetchRequest.sortDescriptors = @[ageSort, firstNameSort];
    NSError *sortRequestError = nil;
    /* And execute the fetch request on the context */
    NSArray *sortPersons =
    [self.managedObjectContext executeFetchRequest:sortFetchRequest
                                             error:&sortRequestError];
    for (Person *person in sortPersons){
        NSLog(@"First Name = %@", person.firstname);
        NSLog(@"Last Name = %@", person.lastname);
        NSLog(@"Age = %lu", (unsigned long)[person.age unsignedIntegerValue]);
    }
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}


// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DemoModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AppData.DemoModel"];
    
    NSError *error;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    // Allow inferred migration from the original version of the application.
    NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption : @YES, NSInferMappingModelAutomaticallyOption : @YES };
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end

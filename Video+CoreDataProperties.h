//
//  Video+CoreDataProperties.h
//  CoreData
//
//  Created by 茆明辉 on 16/1/7.
//  Copyright © 2016年 com.mmh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Video.h"

NS_ASSUME_NONNULL_BEGIN

@interface Video (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *videoId;
@property (nullable, nonatomic, retain) NSNumber *size;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *url;

@end

NS_ASSUME_NONNULL_END

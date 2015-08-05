//
//  NewsArticle+CoreDataProperties.h
//  
//
//  Created by KEEVIN MITCHELL on 8/4/15.
//
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "NewsArticle.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsArticle (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *itemDescription;
@property (nullable, nonatomic, retain) NSData *thumbnailImage;
@property (nullable, nonatomic, retain) NSData *detailImage;

@end

NS_ASSUME_NONNULL_END

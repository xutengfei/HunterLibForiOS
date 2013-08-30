//
//  DTObjectExtend.h
//  Wallpaper
//
//  Created by lloyd sheng on 4/3/12.
//  Copyright (c) 2012 duitang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface NSObject(DTAdditions)

- (BOOL)isNull;

@end

@interface NSNumber(DTAdditions)

- (int)safeIntValue;

@end

@interface UIView (DTAdditions)

- (void)removeAllSubviews;
- (UIImage *)toImage;

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;
- (void)setRoundedCornerWithCoverImage:(UIImage*)image;

@end

@interface NSDate (DTAdditions)
- (NSString*)stringWithFormat:(NSString*)fmt;
+ (NSDate*)dateFromString:(NSString*)str withFormat:(NSString*)fmt;
@end

@interface UIImage (DTAdditions)
+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage*)scaleToNewSize:(CGSize)size;
@end

@interface NSString (DTAdditions)

- (NSString *)trim;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

- (BOOL)isNull;

@end

@interface UIToolbar (DTAdditions)
- (UIBarButtonItem*)itemWithTag:(NSInteger)tag;
- (void)replaceItemWithTag:(NSInteger)tag withItem:(UIBarButtonItem*)item;
@end

@interface NSDictionary(DTAdditions)

- (BOOL)isNull;

- (id)getObjectAtIndex:(NSUInteger)index;

// this is a safe method, you can just call this method
// if there's no key existed in dictionary or the value of key isNull, it will return nil
- (id)getObjectForKey:(NSString*)key;

@end

@interface NSMutableDictionary(DTAdditions)

- (void)safeSetObject:(id)anObject forKey:(id)aKey;

@end

@interface NSArray(DTAdditions)

- (BOOL)isNull;

// this is a safe method, you can just call this method
// if index is larger than count or the value of index isNull, it will return nil
- (id)getObjectAtIndex:(NSUInteger)index;

- (id)getObjectForKey:(NSString*)key;

@end

@interface NSMutableArray(DTAdditions)

- (void)safeAddObject:(id)anObject;
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

@end


@interface NSURL(DTAdditions)

-(NSDictionary *)queryParams;

@end


@interface UIButton(DTAdditions)

-(void)setImageWithName:(NSString *)name;
-(void)setBackgroundImageWithName:(NSString *)name;


@end
//
//  DTObjectExtend.m
//  Wallpaper
//
//  Created by lloyd sheng on 4/3/12.
//  Copyright (c) 2012 duitang. All rights reserved.
//

#import "DTObjectExtend.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark - NSObject(DTAdditions)
@implementation NSObject(DTAdditions)

- (BOOL)isNull {
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}

@end

@implementation NSNumber(DTAdditions)

- (int)safeIntValue
{
    if ([self isNull]) {
        return 0;
    }
    return [self intValue];
}

@end

#pragma mark - UIView (DTAdditions)
@implementation UIView (DTAdditions)

- (void)removeAllSubviews 
{
	while (self.subviews.count) {
		UIView* child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (UIImage *)toImage 
{
	if(UIGraphicsBeginImageContextWithOptions != NULL) {
		UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
	} else {
		UIGraphicsBeginImageContext(self.frame.size);
	}
	
	//获取图像
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
	CGRect rect = self.bounds;
    
    // Create the path 
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect 
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}

- (void)setRoundedCornerWithCoverImage:(UIImage *)image {
    UIImageView* coverView = [[UIImageView alloc] initWithImage:image];
    coverView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:coverView];
    [coverView release];
}

- (void)bindData:(id)data
{
    
}

@end;

#pragma mark - NSDate (DTAdditions)
@implementation NSDate (DTAdditions)

- (NSString*)stringWithFormat:(NSString*)fmt 
{
    static NSDateFormatter *fmtter;
    
    if (fmtter == nil) {
        fmtter = [[NSDateFormatter alloc] init];
    }
    
    if (fmt == nil || [fmt isEqualToString:@""]) {
        fmt = @"HH:mm:ss";
    }
    
    [fmtter setDateFormat:fmt];
    
    return [fmtter stringFromDate:self];
}

+ (NSDate*)dateFromString:(NSString*)str withFormat:(NSString*)fmt 
{
    static NSDateFormatter *fmtter;
    
    if (fmtter == nil) {
        fmtter = [[NSDateFormatter alloc] init];
    }
    
    if (fmt == nil || [fmt isEqualToString:@""]) {
        fmt = @"HH:mm:ss";
    }
    
    [fmtter setDateFormat:fmt];
    
    return [fmtter dateFromString:str];
}

@end

#pragma mark - UIImage (DTAdditions)
@implementation UIImage (DTAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage*)scaleToNewSize:(CGSize)size 
{
	// 创建一个bitmap的context
	UIGraphicsBeginImageContext(size);// 并把它设置成为当前正在使用的context
	[self drawInRect:CGRectMake(0, 0, size.width, size.height)];	// 绘制改变大小的图片
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();// 从当前context中创建一个改变大小后的图片
	UIGraphicsEndImageContext();// 使当前的context出堆栈
	return scaledImage;// 返回新的改变大小后的图片
}

@end

#pragma mark - NSString (DTAdditions)
@implementation NSString (DTAdditions)

- (NSString *)trim 
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),
                                                                           kCFStringEncodingUTF8);
    return [result autorelease];
}

- (NSString *)URLDecodedString 
{
    NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, 
                                                                                           (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
    return [result autorelease];
}

- (BOOL)isNull {
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        if (self.length > 0) {
            return NO;
        }
    }
    return YES;
}

@end

#pragma mark - UIToolbar (DTAdditions)
@implementation UIToolbar (DTAdditions)

- (UIBarButtonItem*)itemWithTag:(NSInteger)tag 
{
    for (UIBarButtonItem* button in self.items) {
        if (button.tag == tag) {
            return button;
        }
    }
    return nil;
}


- (void)replaceItemWithTag:(NSInteger)tag withItem:(UIBarButtonItem*)item 
{
    NSInteger buttonIndex = 0;
    for (UIBarButtonItem* button in self.items) {
        if (button.tag == tag) {
            NSMutableArray* newItems = [NSMutableArray arrayWithArray:self.items];
            [newItems replaceObjectAtIndex:buttonIndex withObject:item];
            self.items = newItems;
            break;
        }
        ++buttonIndex;
    }
}

@end

#pragma mark - NSDictionary(DTAdditions)
@implementation NSDictionary(DTAdditions)

- (BOOL)isNull {
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        if (self.count > 0) {
            return NO;
        }
    }
    return YES;
}

- (id)getObjectAtIndex:(NSUInteger)index {
    return nil;
}

- (id)getObjectForKey:(NSString *)key {
    if (![key isNull] && ![self isNull]) {
        id value = [self objectForKey:key];
        if (value != nil && ![value isKindOfClass:[NSNull class]]) {
            return value;
        }
    }
    return nil;
}

@end

#pragma mark - NSMutableDictionary(DTAdditions)
@implementation NSMutableDictionary(DTAdditions)

- (void)safeSetObject:(id)anObject forKey:(id)aKey {
    if (anObject && ![anObject isNull] && ![aKey isNull] && [aKey isKindOfClass:[NSString class]]) {
        [self setObject:anObject forKey:aKey];
    }
}

@end

#pragma mark - NSArray(DTAdditions)
@implementation NSArray(DTAdditions)

- (BOOL)isNull {
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        if (self.count > 0) {
            return NO;
        }
    }
    return YES;
}

- (id)getObjectAtIndex:(NSUInteger)index {
    if (![self isNull]) {
        if (index < self.count) {
            id value = [self objectAtIndex:index];
            if (value != nil && ![value isKindOfClass:[NSNull class]]) {
                return value;
            }
        }
    }
    return nil;
}

- (id)getObjectForKey:(NSString *)key {
    return nil;
}

@end

#pragma mark - NSMutableArray(DTAdditions)
@implementation NSMutableArray(DTAdditions)

- (void)safeAddObject:(id)anObject{
    if (anObject && ![anObject isNull]) {
        [self addObject:anObject];
    }
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && ![anObject isNull] && index < self.count) {
        [self insertObject:anObject atIndex:index];
    }
}
@end

#pragma mark - NSURL
@implementation NSURL(DTAdditions)

-(NSDictionary *)queryParams {
    NSString *query = [self query];
    if(!query||[query length]==0) return nil;
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    for(NSString* parameter in [query componentsSeparatedByString:@"&"]) {
        NSRange range = [parameter rangeOfString:@"="];
        if(range.location!=NSNotFound)
            [parameters setValue:[[parameter substringFromIndex:range.location+range.length]
                                  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                          forKey:[[parameter substringToIndex:range.location]
                                  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        else [parameters setValue:@""
                           forKey:[parameter stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return parameters;
}

@end

@implementation UIButton(DTAdditions)

- (void)setImageWithName:(NSString *)name
{
    UIImage *normalImage = [UIImage imageNamed:name];
    UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", name]];
    UIImage *highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted", name]];
    highlightedImage = highlightedImage ? highlightedImage : selectedImage;

    [self setImage:normalImage forState:UIControlStateNormal];
    [self setImage:selectedImage forState:UIControlStateSelected];
    [self setImage:highlightedImage forState:UIControlStateHighlighted];    
}

- (void)setBackgroundImageWithName:(NSString *)name
{
    UIImage *normalImage = [UIImage imageNamed:name];
    UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", name]];
    UIImage *highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted", name]];
    highlightedImage = highlightedImage ? highlightedImage : selectedImage;
    
    [self setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
}

@end

#import <Foundation/Foundation.h>
@import UIKit;

typedef NS_ENUM(NSUInteger, Objc_ConstraintRelation) {
    Objc_ConstraintRelationEqual = 1,
    Objc_ConstraintRelationGreaterThanOrEqual = 2,
    Objc_ConstraintRelationLessThanOrEqual = 3,
};

NS_SWIFT_UNAVAILABLE("This class is for obj-c compatibility.  Swift should use the Constraint class directly")
@interface Objc_Constraint: NSObject {
@public
    Objc_Constraint *(^appended)(Objc_Constraint *);
    void(^addConstraintsToViewHorizontallyWithOptions)(UIView *view, NSLayoutFormatOptions options);
    void(^addConstraintsToViewVerticallyWithOptions)(UIView *view, NSLayoutFormatOptions options);
    NSArray <NSLayoutConstraint *> *(^toNSLayoutConstraintsHorizontally)(NSLayoutFormatOptions options);
    NSArray <NSLayoutConstraint *> *(^toNSLayoutConstraintsVertically)(NSLayoutFormatOptions options);
}

+ (instancetype)leading;
+ (instancetype)trailing;
+ (instancetype)view:(UIView *)view;
+ (instancetype)view:(UIView *)view withRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value;
+ (instancetype)view:(UIView *)view withRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value priority:(NSInteger)priority;
+ (instancetype)lengthOfView:(UIView *)view1 equalsView:(UIView *)view2;

+ (instancetype)spacerWithRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value;
+ (instancetype)spacerWithRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value priority:(NSInteger)priority;

@end



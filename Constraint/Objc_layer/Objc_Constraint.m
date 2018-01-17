
#import "Objc_Constraint.h"

// MARK: - Informal protocol
@interface NSObject (Indirectly_involke_Constraints)

// Stand-Alone Components
+ (id)_constraint_Leading;
+ (id)_constraint_Trailing;
+ (id)_constraint_View:(UIView *)view withRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value priority:(NSInteger)priority;
+ (id)_constraint_lengthOfView:(UIView *)view1 equalsView:(UIView *)view2;

+ (id)_constraint_spacerWithRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value priority:(NSInteger)priority;

// Combine components
+ (id)_constraint_Appended:(id)previous toCurrent:(id)current;
+ (NSArray<NSLayoutConstraint *> *)_constraint_toNSLayoutConstraintsHorizontally:(id)previous withOptions:(NSLayoutFormatOptions)options;
+ (NSArray<NSLayoutConstraint *> *)_constraint_toNSLayoutConstraintsVertically:(id)previous withOptions:(NSLayoutFormatOptions)options;

@end

@implementation Objc_Constraint {
    id _swiftConstraint;
}

- (instancetype)init {
    if (self = [super init]) {
        __weak Objc_Constraint *weakSelf = self;
        self->appended = ^(Objc_Constraint *constraint) {
           return [weakSelf appendConstraint:constraint];
        };
        self->addConstraintsToViewHorizontallyWithOptions = ^(UIView *view, NSLayoutFormatOptions options) {
            [weakSelf addConstraintsToView:view horizontallyWithOptions:options];
        };
        self->addConstraintsToViewVerticallyWithOptions = ^(UIView *view, NSLayoutFormatOptions options) {
            [weakSelf addConstraintsToView:view verticallyWithOptions:options];
        };
        self->toNSLayoutConstraintsHorizontally = ^(NSLayoutFormatOptions options){
            return [weakSelf _toNSLayoutConstraintsHorizontallyWithOptions:options];
        };
        self->toNSLayoutConstraintsVertically = ^(NSLayoutFormatOptions options){
            return [weakSelf _toNSLayoutConstraintsVerticallyWithOptions:options];
        };
    }
    return self;
}

+ (instancetype)leading {
    Objc_Constraint *newConstraint = [Objc_Constraint new];
    newConstraint->_swiftConstraint = [NSObject _constraint_Leading];
    return newConstraint;
}

+ (instancetype)trailing {
    Objc_Constraint *newConstraint = [Objc_Constraint new];
    newConstraint->_swiftConstraint = [NSObject _constraint_Trailing];
    return newConstraint;
}

+ (Objc_Constraint *)view:(UIView *)view {
    return [self view:view withRelation:0 value:-1];
}

+ (instancetype)view:(UIView *)view withRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value {
    return [self view:view withRelation:relation value:value priority:1000];
}

+ (instancetype)view:(UIView *)view withRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value priority:(NSInteger)priority {
    Objc_Constraint *newConstraint = [Objc_Constraint new];
    newConstraint->_swiftConstraint = [NSObject _constraint_View:view withRelation:relation value:value priority:priority];
    return newConstraint;
}

+ (instancetype)lengthOfView:(UIView *)view1 equalsView:(UIView *)view2 {
    Objc_Constraint *newConstraint = [Objc_Constraint new];
    newConstraint->_swiftConstraint = [NSObject _constraint_lengthOfView:view1 equalsView:view2];
    return newConstraint;
}

+ (instancetype)spacerWithRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value {
    return [self spacerWithRelation:relation value:value priority:1000];
}

+ (instancetype)spacerWithRelation:(Objc_ConstraintRelation)relation value:(CGFloat)value priority:(NSInteger)priority {
    Objc_Constraint *newConstraint = [Objc_Constraint new];
    newConstraint->_swiftConstraint = [NSObject _constraint_spacerWithRelation:relation value:value priority:priority];
    return newConstraint;
}


- (Objc_Constraint *)appendConstraint:(Objc_Constraint *)constraint {
    id previousSwiftConstraint = self->_swiftConstraint;
    id currentSwiftConstraint = constraint->_swiftConstraint;
    
    Objc_Constraint *newConstraint = [Objc_Constraint new];
    newConstraint->_swiftConstraint = [NSObject _constraint_Appended:previousSwiftConstraint
                                                           toCurrent:currentSwiftConstraint];
    return newConstraint;
}

- (NSArray <NSLayoutConstraint *> *)_toNSLayoutConstraintsHorizontallyWithOptions:(NSLayoutFormatOptions)options {
    return [NSObject _constraint_toNSLayoutConstraintsHorizontally:self->_swiftConstraint
                                                       withOptions:options];
}

- (NSArray <NSLayoutConstraint *> *)_toNSLayoutConstraintsVerticallyWithOptions:(NSLayoutFormatOptions)options {
    return [NSObject _constraint_toNSLayoutConstraintsVertically:self->_swiftConstraint
                                                     withOptions:options];
}

- (void)addConstraintsToView:(UIView *)view horizontallyWithOptions:(NSLayoutFormatOptions)options {
    NSArray <NSLayoutConstraint *> *arr = [self _toNSLayoutConstraintsHorizontallyWithOptions:options];
    [view addConstraints:arr];
}

- (void)addConstraintsToView:(UIView *)view verticallyWithOptions:(NSLayoutFormatOptions)options {
    NSArray <NSLayoutConstraint *> *arr = [self _toNSLayoutConstraintsVerticallyWithOptions:options];
    [view addConstraints:arr];
}

@end


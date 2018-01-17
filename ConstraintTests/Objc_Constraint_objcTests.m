
#import <XCTest/XCTest.h>
#import <Constraint/Constraint.h>

@interface Objc_Constraint_objcTests : XCTestCase

@end

@implementation Objc_Constraint_objcTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConstrainSubviewWithSpecificMargins {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIView *dummyView = [UIView new];
    dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    [canvas addSubview:dummyView];

    [Objc_Constraint leading]
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:5])
    ->appended([Objc_Constraint view:dummyView])
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:5])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewHorizontallyWithOptions(canvas, 0);
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:5])
    ->appended([Objc_Constraint view:dummyView])
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:5])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);
    
    [canvas setNeedsLayout];
    [canvas layoutIfNeeded];
    
    CGRect resultRect = dummyView.frame;
    CGRect expectedRect = CGRectMake(5, 5, 90, 90);
    XCTAssertTrue(CGRectEqualToRect(resultRect, expectedRect)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect)
                  , NSStringFromCGRect(expectedRect));
    
}

- (void)testConstrainSubviewWithDefaultMargins {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIView *dummyView = [UIView new];
    dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    [canvas addSubview:dummyView];
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:dummyView])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewHorizontallyWithOptions(canvas, 0);
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:dummyView])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);
    
    [canvas setNeedsLayout];
    [canvas layoutIfNeeded];
    
    CGRect resultRect = dummyView.frame;
    CGRect expectedRect = CGRectMake(8, 8, 84, 84);
    XCTAssertTrue(CGRectEqualToRect(resultRect, expectedRect)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect)
                  , NSStringFromCGRect(expectedRect));
    
}

- (void)testConstrainSubviewWithSpecificSize {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIView *dummyView = [UIView new];
    dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    [canvas addSubview:dummyView];
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:dummyView withRelation:Objc_ConstraintRelationEqual value:13])
    ->addConstraintsToViewHorizontallyWithOptions(canvas, 0);
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:dummyView withRelation:Objc_ConstraintRelationEqual value:14])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);
    
    [canvas setNeedsLayout];
    [canvas layoutIfNeeded];
    
    CGRect resultRect = dummyView.frame;
    CGRect expectedRect = CGRectMake(8, 8, 13, 14);
    XCTAssertTrue(CGRectEqualToRect(resultRect, expectedRect)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect)
                  , NSStringFromCGRect(expectedRect));
    
}

- (void)testConstrainSubviewWithSpecificSize_greaterThanValue {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIView *dummyView = [UIView new];
    UIView *corner = [UIView new];
    dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    corner.translatesAutoresizingMaskIntoConstraints = NO;
    [canvas addSubview:dummyView];
    [canvas addSubview:corner];
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:dummyView withRelation:Objc_ConstraintRelationGreaterThanOrEqual value:13])
    ->appended([Objc_Constraint view:corner withRelation:Objc_ConstraintRelationEqual value:10])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewHorizontallyWithOptions(canvas, 0);
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:dummyView withRelation:Objc_ConstraintRelationEqual value:14])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);

    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:corner withRelation:Objc_ConstraintRelationEqual value:10])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);

    [canvas setNeedsLayout];
    [canvas layoutIfNeeded];
    
    CGRect resultRect = dummyView.frame;
    CGRect expectedRect = CGRectMake(8, 8, canvas.frame.size.width - (8 + 8 + 10 + 8), 14);
    XCTAssertTrue(CGRectEqualToRect(resultRect, expectedRect)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect)
                  , NSStringFromCGRect(expectedRect));
    
}

- (void)testConstrainSubUILabelWithSpecificSize_lessThenValue_viewheight {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UILabel *dummyView = [UILabel new];
    dummyView.text = @"a";
    dummyView.font = [UIFont fontWithName:@"Arial" size:16];
    dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    [canvas addSubview:dummyView];
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:dummyView])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewHorizontallyWithOptions(canvas, 0);
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint view:dummyView withRelation:Objc_ConstraintRelationLessThanOrEqual value:canvas.frame.size.height])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);
    
    [canvas setNeedsLayout];
    [canvas layoutIfNeeded];
    
    CGRect resultRect = dummyView.frame;
    CGRect expectedRect = CGRectMake(8, 0, 84, 18);
    XCTAssertTrue(CGRectEqualToRect(resultRect, expectedRect)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect)
                  , NSStringFromCGRect(expectedRect));
    
}

- (void)testConstrainSubUILabelWithSpecificSize_greaterThenValue_bottom_spacer {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UILabel *dummyView = [UILabel new];
    dummyView.text = @"a";
    dummyView.font = [UIFont fontWithName:@"Arial" size:16];
    dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    [canvas addSubview:dummyView];
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:dummyView])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewHorizontallyWithOptions(canvas, 0);
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint view:dummyView])
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationGreaterThanOrEqual value:0])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);
    
    [canvas setNeedsLayout];
    [canvas layoutIfNeeded];
    
    CGRect resultRect = dummyView.frame;
    CGRect expectedRect = CGRectMake(8, 0, 84, 18);
    XCTAssertTrue(CGRectEqualToRect(resultRect, expectedRect)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect)
                  , NSStringFromCGRect(expectedRect));
    
}

- (void)testConstrainSubUILabelWithSpecificSize_lessThenThenValue_bottom_spacer {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UILabel *dummyView = [[UILabel alloc] initWithFrame:canvas.frame];
    dummyView.text = @"a";
    dummyView.font = [UIFont fontWithName:@"Arial" size:16];
    dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    [canvas addSubview:dummyView];
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint view:dummyView])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewHorizontallyWithOptions(canvas, 0);
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint view:dummyView])
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationLessThanOrEqual value:canvas.frame.size.height])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);
    
    [canvas setNeedsLayout];
    [canvas layoutIfNeeded];
    
    CGRect resultRect = dummyView.frame;
    CGRect expectedRect = CGRectMake(8, 0, 84, 18);
    XCTAssertTrue(CGRectEqualToRect(resultRect, expectedRect)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect)
                  , NSStringFromCGRect(expectedRect));
    
}

// MARK: - toNSLayoutConstraint tests

- (void)testConstrainSubviewWithSpecificMargins_toNSLayoutConstraintsHorizontally {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIView *dummyView = [UIView new];
    dummyView.translatesAutoresizingMaskIntoConstraints = NO;
    [canvas addSubview:dummyView];
    
    [canvas addConstraints:[Objc_Constraint leading]
     ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:5])
     ->appended([Objc_Constraint view:dummyView])
     ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:5])
     ->appended([Objc_Constraint trailing])
     ->toNSLayoutConstraintsHorizontally(0)];
    
    [canvas addConstraints:[Objc_Constraint leading]
     ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:5])
     ->appended([Objc_Constraint view:dummyView])
     ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:5])
     ->appended([Objc_Constraint trailing])
     ->toNSLayoutConstraintsVertically(0)];
    
    [canvas setNeedsLayout];
    [canvas layoutIfNeeded];
    
    CGRect resultRect = dummyView.frame;
    CGRect expectedRect = CGRectMake(5, 5, 90, 90);
    XCTAssertTrue(CGRectEqualToRect(resultRect, expectedRect)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect)
                  , NSStringFromCGRect(expectedRect));
    
}

- (void)test_lengthOfViewEqualsView_widthsOfBothViewsEqual {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIView *v1 = [UIView new];
    UIView *v2 = [UIView new];
    [canvas addSubview:v1];
    [canvas addSubview:v2];
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint lengthOfView:v1 equalsView:v2])
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint lengthOfView:v2 equalsView:v1])
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewHorizontallyWithOptions(canvas, 0);
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint view:v1])
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);
    
    [Objc_Constraint leading]
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint view:v2])
    ->appended([Objc_Constraint spacerWithRelation:Objc_ConstraintRelationEqual value:0])
    ->appended([Objc_Constraint trailing])
    ->addConstraintsToViewVerticallyWithOptions(canvas, 0);
    
    
    [canvas setNeedsLayout];
    [canvas layoutIfNeeded];
    
    CGRect resultRect1 = v1.frame;
    CGRect resultRect2 = v2.frame;

    CGRect expectedRect1 = CGRectMake(0, 0, 5, 10);
    CGRect expectedRect2 = CGRectMake(5, 0, 5, 10);

    XCTAssertTrue(CGRectEqualToRect(resultRect1, expectedRect1)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect1)
                  , NSStringFromCGRect(expectedRect1));
    
    XCTAssertTrue(CGRectEqualToRect(resultRect2, expectedRect2)
                  , @"Result rect %@ does not equal %@"
                  , NSStringFromCGRect(resultRect2)
                  , NSStringFromCGRect(expectedRect2));
}

// MARK: - Error handling

- (void)test_toLayoutHorizontally_objcBridge_errorState {
    NSArray<NSLayoutConstraint *> *c = [NSObject performSelector:NSSelectorFromString(@"_constraint_toNSLayoutConstraintsHorizontally:withOptions:") withObject:nil withObject:nil];
    XCTAssertNotNil(c);
    XCTAssertEqual([c count], 0);
}

- (void)test_toLayoutVertically_objcBridge_errorState {
    NSArray<NSLayoutConstraint *> *c = [NSObject performSelector:NSSelectorFromString(@"_constraint_toNSLayoutConstraintsVertically:withOptions:") withObject:nil withObject:nil];
    XCTAssertNotNil(c);
    XCTAssertEqual([c count], 0);
}

- (void)test_appended_objcBridge_errorState {
    NSString *theWrongObject = @"";
    NSArray<NSLayoutConstraint *> *c = [NSObject performSelector:NSSelectorFromString(@"_constraint_Appended:toCurrent:") withObject:theWrongObject withObject:nil];
    XCTAssertEqual((id)c, (id)theWrongObject);
}

@end

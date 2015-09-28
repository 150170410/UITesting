//
//  UITestingDemoUITests.m
//  UITestingDemoUITests
//
//  Created by Pham Chi Cong on 9/23/15.
//  Copyright © 2015 Transcosmos Technologic Arts. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UITestingDemoUITests : XCTestCase {
    XCUIApplication* application;
}

@end

@implementation UITestingDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = YES;
    // UI tests must launch the application that they test.
    //Doing this in setup will make sure it happens for each test method.
    application = [[XCUIApplication alloc] init];
    [application launch];
    // In UI tests it’s important to set the initial state -
    //such as interface orientation - required for your tests before they run.
    //The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [application terminate];
    application = nil;
    [super tearDown];
}

- (void)testUIDeleteAllCells {
    XCUIElement* devicesNavigationBar = application.navigationBars[@"Devices"];
    [devicesNavigationBar.buttons[@"Edit"] tap];
    
    XCUIElementQuery* tables = application.tables;
    while (tables.cells.count > 0) {
        int count = (int)tables.cells.count;
        XCUIElement* cell = [tables.cells elementBoundByIndex:0];
        XCUIElement* deletedCell = [cell.buttons matchingPredicate:[NSPredicate predicateWithFormat:@"label BEGINSWITH 'Delete'"]].element;
        [deletedCell tap];
        XCUIElement* deleteButton = [[[cell childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Delete"] elementBoundByIndex:0];
        [deleteButton tap];
        XCTAssertEqual(tables.cells.count, (count - 1));
    }
    XCTAssertEqual(tables.cells.count, 0);//Empty
    [devicesNavigationBar.buttons[@"Done"] tap];
}

- (void)testUIAddNewItem {
    XCUIElementQuery* tables = application.tables;
    int count = (int)tables.cells.count;
    
    [application.navigationBars[@"Devices"].buttons[@"Add"] tap];
    XCUIElement *textField = [[[[[application.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Add device"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeTextField].element;
    [textField tap];
    [textField typeText:@"iPad Air 2"];
    [application.navigationBars[@"Add device"].buttons[@"Done"] tap];
    
    XCTAssertEqual(tables.cells.count, (count + 1));//Add 1 item
}

- (void)testUIReorderCells {
    XCUIElement* devicesNavigationBar = application.navigationBars[@"Devices"];
    [devicesNavigationBar.buttons[@"Edit"] tap];
    
    XCUIElementQuery* tables = application.tables;
    int itemCount = (int)tables.cells.count;
    int counter = 0;
    while (counter < (itemCount - 1)) {
        XCUIElement* cell = [tables.cells elementBoundByIndex:counter];
        XCUIElement* reorderButton = [cell.buttons matchingPredicate:[NSPredicate predicateWithFormat:@"label BEGINSWITH 'Reorder'"]].element;
        int nextCounter = (counter + 1);
        XCUIElement* cell1 = [tables.cells elementBoundByIndex:nextCounter];
        XCUIElement* reorderButton1 = [cell1.buttons matchingPredicate:[NSPredicate predicateWithFormat:@"label BEGINSWITH 'Reorder'"]].element;
        [reorderButton pressForDuration:2 thenDragToElement:reorderButton1];
        counter++;
    }
    [devicesNavigationBar.buttons[@"Done"] tap];
}

@end

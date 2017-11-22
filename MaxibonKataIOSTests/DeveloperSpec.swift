//
//  DeveloperSpec.swift
//  MaxibonKataIOSTests
//
//  Created by Fernando García Fernández on 22/11/17.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class DeveloperSpec: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testAll(){
        property("The developer always take a positive number of Maxibons", arguments: CheckerArguments(maxAllowableSuccessfulTests: 2000)) <- forAll { (developer: Developer) in
            print(developer.numberOfMaxibonsToGet)
            return developer.numberOfMaxibonsToGet >= 0
        }
        
    }
}

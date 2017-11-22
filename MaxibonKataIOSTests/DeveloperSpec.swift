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

    func testNameOfTheDeveloperIsTheSameIProvideInTheCreation(){
        property("NameOfTheDeveloperIsTheSameIProvideInTheCreation") <- forAll(String.arbitrary, pf: { (name: String) -> Testable in
            let developer = Developer(name: name, numberOfMaxibonsToGet: 0)
            print(name)
            return developer.name == name
        })
    }
    
    func testAllHungryDevelopers(){
        property("The developer always take a positive number of Maxibons", arguments: CheckerArguments(maxAllowableSuccessfulTests: 2000)) <- forAll(Developer.arbitraryHungry, pf: { (developer: Developer) -> Testable in
            print(developer.numberOfMaxibonsToGet)
            return developer.numberOfMaxibonsToGet >= 0
        })
    }
}

//
//  KarumiHQsSpec.swift
//  MaxibonKataIOSTests
//
//  Created by Fernando García Fernández on 22/11/17.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class KarumiHQsSpec: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFrigeNeverHaveMinusThatTwoMaxibons(){
        property("FrigeNeverHaveMinusThatTwoMaxibons", arguments: CheckerArguments(maxAllowableSuccessfulTests: 2000)) <- forAll({ (developer: Developer) -> Testable in
            let karumiHQ = KarumiHQs()
            karumiHQ.openFridge(developer)
            print(karumiHQ.maxibonsLeft)
            return karumiHQ.maxibonsLeft >= 2
        })
    }
    
    func testFrigeNeverHaveMinusThatTwoMaxibonsWithNotHungryDevelopers(){
        property("FrigeNeverHaveMinusThatTwoMaxibonsWithNotHungryDevelopers", arguments: CheckerArguments(maxAllowableSuccessfulTests: 2000)) <- forAll(Developer.arbitraryNotSoHungry, pf: { (developer: Developer) -> Testable in
            let karumiHQ = KarumiHQs()
            karumiHQ.openFridge(developer)
            print(karumiHQ.maxibonsLeft)
            return karumiHQ.maxibonsLeft >= 2
        })
    }
    
    func testFrigeMaximHaveTenMaxibons(){
        property("FrigeMaximHaveTenMaxibons", arguments: CheckerArguments(maxAllowableSuccessfulTests: 2000)) <- forAll(Developer.arbitraryHungry, pf: { (developer: Developer) -> Testable in
            let karumiHQ = KarumiHQs(chat: MockChat())
            karumiHQ.openFridge(developer)
            print(karumiHQ.maxibonsLeft)
            
            return karumiHQ.maxibonsLeft == self.getMaxi(initialMaxibons: 10, numberOfMaxibonsToGrab: developer.numberOfMaxibonsToGet)
        })
    }
    
    func testFrigeNeverHaveMinusThatTwoMaxibonsWithAnArrayOfDevelopers(){
        property("HowMaxibonsLeftWithNoHungryDevelopers", arguments: CheckerArguments(maxAllowableSuccessfulTests: 2000)) <- forAll({ (developer: ArrayOf<Developer>) -> Testable in
            let karumiHQ = KarumiHQs(chat: MockChat())
            karumiHQ.openFridge(developer.getArray)
            print(karumiHQ.maxibonsLeft)
            return karumiHQ.maxibonsLeft >= 2
        }).verbose
    }
    
    func testInvoqueChatWithMessage(){
        property("InvoqueChatWithMessage") <- forAll(Developer.arbitraryHungry, pf: { (developer: Developer) -> Testable in
            let chat = MockChat()
            let karumiHQ = KarumiHQs(chat: chat)
            karumiHQ.openFridge(developer)
            return chat.messageSent == "Hi guys, I'm \(developer). We need more maxibons!"
        }).verbose
    }
    
    func getMaxi(initialMaxibons: Int, numberOfMaxibonsToGrab: Int) -> Int{
        var maxibonsLeft = initialMaxibons
        maxibonsLeft -= numberOfMaxibonsToGrab
        if maxibonsLeft < 0{
            maxibonsLeft = 0
        }
        if maxibonsLeft <= 2{
            maxibonsLeft += 10
        }
        return maxibonsLeft
    }
    
}

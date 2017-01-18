//
//  PrettySegueTests.swift
//
//  Copyright (c) 2017 Stan H (shomishinec@gmail.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
@testable import PrettySegue

//
// Current architecture is not pretty testable,
// but i am going to fix it in next versions
//

class PrettySegueTests: XCTestCase {

	var segueId = "segue"
	let intParam: Int = 10
	let classParam: Param = Param(classId: "param")
	let storyboardName = "Storyboard"

	var window: UIWindow!
	var storyboard: UIStoryboard?
	var testableVC: TestableViewController?

	var sender: UIButton!

    override func setUp() {
        super.setUp()

		window = UIWindow(frame: UIScreen.main.bounds)
		storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: type(of: self)))
		let vc = storyboard?.instantiateViewController(withIdentifier: "TestableViewController")
		window.rootViewController = vc

		if let _tVC = vc as? TestableViewController {
			testableVC = _tVC
		} else {
			XCTFail("mock controller is nil")
		}

		sender = UIButton()

    }
    
    override func tearDown() {
        super.tearDown()
    }

	func testInternalSegue() {

		let internalSegue = InternalSegue(identifier: segueId, sender: sender) { _ in }

		XCTAssertEqual(segueId, internalSegue.identifier, "incorect init, segue id is wrong")
		XCTAssertTrue(sender === internalSegue.sender as? UIButton, "incorect init, sender is wrong")
		XCTAssertNotNil(internalSegue.configurator, "incorect init, configurator is wrong")
	}

	func testPerformSegue() {

		let configurator = { [unowned self] (otherVC: OtherTestableViewController) in
			otherVC.classParam = self.classParam
			otherVC.valueParam = self.intParam
		}

		let iSegue = InternalSegue(identifier: segueId, sender: sender, configurator: configurator)

		iSegue.perform(viewController: testableVC!)

		XCTAssertEqual(testableVC?.countOfConfig, 0)
		XCTAssertEqual(testableVC?.countOfPrepare, 1)
	}

	func testPretySegueExtension() {

		testableVC?.delegate = self
		testableVC?.performSegueToOtherVC(segueId: segueId, sender: sender, valueParam: intParam, classParam: classParam)

		XCTAssertEqual(testableVC?.countOfConfig, 1)
		XCTAssertEqual(testableVC?.countOfPrepare, 1)
	}

}

extension PrettySegueTests: TestableDelegate {

	func callPrepare(segue: UIStoryboardSegue, sender: Any?) {
		XCTAssert(sender as? UIButton === self.sender, "sender should be the same")
	}
}

//
//  TestableViewController.swift
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

import UIKit
import PrettySegue

protocol TestableDelegate: class {
	func callPrepare(segue: UIStoryboardSegue, sender: Any?)
}

class Param {

	var classId: String

	init(classId: String) {
		self.classId = classId
	}
}

class TestableViewController: UIViewController {

	weak var delegate: TestableDelegate?

	var countOfPrepare: Int = 0
	var countOfConfig: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }

	func performSegueToOtherVC(segueId: String, sender: Any?, valueParam: Int, classParam: Param) {

		performSegue(withIdentifier: segueId, sender: sender) { [weak self] (otherVC: OtherTestableViewController) in
			otherVC.classParam = classParam
			otherVC.valueParam = valueParam
			otherVC.delegate = self?.delegate
			self?.countOfConfig += 1
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		countOfPrepare += 1
		delegate?.callPrepare(segue: segue, sender: sender)
	}

}

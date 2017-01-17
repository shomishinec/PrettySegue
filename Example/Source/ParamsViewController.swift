//
//  ParamsViewController.swift
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

class ParamsViewController: UIViewController {

	@IBOutlet weak var widthTestField: UITextField!
	@IBOutlet weak var heightTextField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func calculateTap() {

		var width = 0
		var height = 0

		if let w = Int(widthTestField.text!) {
			width = w
		}

		if let h = Int(heightTextField.text!) {
			height = h
		}

		performSegue(withId: "area", sender: self) { (areaVC: AreaViewController) in
			areaVC.height = height
			areaVC.width = width
		}
	}
}

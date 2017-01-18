//
//  PrettySegue.swift
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

public typealias Controller = UIViewController

extension UIViewController {

	/**
	Initiates the segue with the specified identifier from the current view controller's storyboard file.
	- Parameters:
		- identifier: Segue identifier
	 	- sender: Please check the original method to get info about this parametr
	 	- configurator: Closure with initialized destanation ViewController

	 - Returns: Void
	*/
	public final func performSegue<C: Controller>(withIdentifier identifier: String,
												  sender: Any? = nil,
												  configurator: ((C) -> (Void))? = nil) {

		objc_sync_enter(self)
		type(of: self).swizzlePrepareForSegue()

		let segue = InternalSegue(identifier: identifier, sender: sender, configurator: configurator)
		segue.perform(viewController: self)

		type(of: self).swizzlePrepareForSegue()
		objc_sync_exit(self)
	}

	func swizzledPrepareForSegue(for segue: UIStoryboardSegue, sender: Any?) {

		if let _sender = sender as? SenderTuple {
			self.swizzledPrepareForSegue(for: segue, sender: _sender.realSender)
			_sender.transmitter?(segue)
		}
	}

	class func swizzlePrepareForSegue() {

		let originalSelector = #selector(UIViewController.prepare(for:sender:))
		let swizzledSelector = #selector(UIViewController.swizzledPrepareForSegue(for:sender:))

		let originalMethod = class_getInstanceMethod(self, originalSelector)
		let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)

		method_exchangeImplementations(originalMethod, swizzledMethod)
	}
}

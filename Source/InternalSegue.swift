//
//  InternalSegue.swift
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

internal typealias Transmitter = (UIStoryboardSegue) -> (Void)
internal typealias SenderTuple = (realSender: Any?, transmitter: Transmitter?)

internal class InternalSegue<C: Controller> {
	internal typealias Configurator = (C) -> (Void)
	var sender: Any?
	var identifier: String
	var configurator: Configurator?

	init(identifier: String, sender: Any?, configurator: Configurator? = nil) {
		self.identifier = identifier
		self.sender = sender
		self.configurator = configurator
	}

	func perform(viewController: UIViewController) {

		let transmitter: Transmitter = { [unowned self] segue in
			if segue.identifier == self.identifier {
				if let destination = segue.destination as? C {
					self.configurator?(destination)
				}
			}
		}

		let sender = SenderTuple(realSender: self.sender, transmitter: transmitter)
		viewController.performSegue(withIdentifier: identifier, sender: sender)
	}

}

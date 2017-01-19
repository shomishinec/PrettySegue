# PrettySegue
Storyboard segues with closures

[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=5880cb4d9147900100091f9d&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/5880cb4d9147900100091f9d/build/latest?branch=master)
[![Version](https://img.shields.io/cocoapods/v/PrettySegue.svg?style=flat)](http://cocoapods.org/pods/PrettySegue)
[![License](https://img.shields.io/cocoapods/l/PrettySegue.svg?style=flat)](http://cocoapods.org/pods/PrettySegue)
[![Platform](https://img.shields.io/cocoapods/p/PrettySegue.svg?style=flat)](http://cocoapods.org/pods/PrettySegue)

## Requirements
- iOS 8.0+
- Xcode 8.2.1 +
- Swift 3.0+

## Installation

PrettySegue is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PrettySegue"
```

## Usage

If you create a segue in storyboard named "area", you can perfrom the segue like this: 

```swift
import PrettySegue

class ViewController: UIViewController {

    // basic
    @IBAction func onBtnA(sender: AnyObject) {
       performSegue(withIdentifier: "area", sender: self) { (areaVC: AreaViewController) in
			    areaVC.height = 10
			    areaVC.width = 10
		  }
    }
}
```


## License

PrettySegue is available under the MIT license. See the LICENSE file for more info.

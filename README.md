# PMOSurvey

PMOSurvey is a library to present a survey view to your users. It uses Firebase config to collect the question and options.

[![Version](https://img.shields.io/cocoapods/v/PMOSurvey.svg?style=flat)](https://cocoapods.org/pods/PMOSurvey)
[![License](https://img.shields.io/cocoapods/l/PMOSurvey.svg?style=flat)](https://cocoapods.org/pods/PMOSurvey)
[![Platform](https://img.shields.io/cocoapods/p/PMOSurvey.svg?style=flat)](https://cocoapods.org/pods/PMOSurvey)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<img src=https://github.com/plus-minus-one/PMOSurvey/blob/main/images/image_example.png width="250" height="400"/>

## Installation

### Step 1: Download Mobile SDK

PMOSurvey is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PMOSurvey'
```
### Step 2: Configure Firebase Config

On the Firebase console navigation bar, click Remote Config. Add a parameter or choose a parameter to edit:

To add a parameter: Click Add Parameter.
To edit a parameter: Click the parameter you want to change.

```json format
{
  "active": true,
  "question": "Where are you from?",
  "options": [
    "Konya",
    "Izmir",
    "Istanbul",
    "Ankara",
    "Edirne"
  ]
}
```
<img src=https://github.com/plus-minus-one/PMOSurvey/blob/main/images/image_firebase.png />

### Step 3: Integrate the PMOSurvey SDK with your app

1. Import the SDK
```swift
import PMOSurvey
```

2. Initialize the SDK with survey properties:
```swift

var prop = PMOSurveyProperties()
prop.plist_key = "pmo_survey"
prop.duration = 10
prop.enable_button_color = UIColor.green
prop.disable_button_color = UIColor.red
PMOSurvey.configure(prop)
```
3. Presenting a Survey to the User
  
```swift
PMOSurvey.shared.isActive { [weak self] (active) in
guard let strongSelf = self else { return }
  if active{
     PMOSurvey.shared.show(strongSelf, delegate: strongSelf)
  }
}
``` 
4. Delegation : The survey respondent data is returned as an PMORespondent. Here's an example:
  
```swift
extension ViewController:PMOSurveyDelegate{
    func respondentDidEndSurvey(_ response: PMORespondent?, error: Error?) {
        if let res = response{
            print("question: " + res.question)
            print("answer: " + res.answer)
        }
    }
}
``` 
        
## Author

support@plusminusone.co

## License

PMOSurvey is available under the MIT license. See the LICENSE file for more info.

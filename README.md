<!--<img src="image/JJHUDLogo.png" width="100%">-->
[![Version](https://img.shields.io/cocoapods/v/JJHUD.svg?style=flat)](http://cocoapods.org/pods/JJHUD)
[![License](https://img.shields.io/cocoapods/l/JJHUD.svg?style=flat)](http://cocoapods.org/pods/JJHUD)
[![Platform](https://img.shields.io/cocoapods/p/JJHUD.svg?style=flat)](http://cocoapods.org/pods/JJHUD)
[![Weibo](https://img.shields.io/badge/微博-@晋先森-yellow.svg?style=flat)](http://weibo.com/3205872327)
<!--[![GitHub stars](https://img.shields.io/github/stars/jinxiansen/JJHUD.svg)](https://github.com/jinxiansen/JJHUD/stargazers)-->

<img src="JJHUDDemo/image/JJHUD.png" width="100%">
#### `JJHUD` is an displays a translucent HUD with an indicator and/or labels .

#### [中文说明](README.zh.md) / [简书介绍](http://www.jianshu.com/p/e8d62e731ab5)
 
## Screenshots

<img src="JJHUDDemo/image/1.gif" width="40%">

## Requirements

`JJHUD` works on ` "Xcode 8.2 , Swift 3 and ios 10+ to build. `
You will need the latest developer tools in order to build `JJHUD`. Old Xcode versions might work, but compatibility will not be explicitly maintained.

## CocoaPods

CocoaPods is the recommended way to add JJHUD to your project.

Add a pod entry for JJHUD to your Podfile.
 
```
pod 'JJHUD'
```
Second, install JJHUD into your project:
 
```
pod install
```


## Manually

1. Download the latest code version .
2. Open your project in Xcode,drag the `JJHUD` folder into your project.  Make sure to select Copy items when asked if you extracted the code archive outside of your project.


## Usage

```
JJHUD.showSuccess(text: "Login success", delay: 2.0)
```

or

```
JJHUD.showLoading()

JJHUD.hide() 
```

For more examples, including how to use JJHUD , take a look at the bundled demo project. API documentation is provided in the header file (JJHUD.swift).

## Contacts	![](JJHUDDemo/image/z.jpg)

#### If you wish to contact me, email at: hi@jinxiansen.com

##### Sina : [@晋先森](http://weibo.com/3205872327)
##### Twitter : [@jinxiansen](https://twitter.com/jinxiansen)

## License	

JJHUD is released under the [MIT license](LICENSE). See LICENSE for details.
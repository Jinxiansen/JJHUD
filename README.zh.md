
##中文说明
####`JJHUD` 是一个半透明的 HUD 指示器。

####注意
`JJHUD` 基于 "Xcode 8.2 / iOS 10 而写 ，请在最新版 Xcode 来编译JJHUD,旧版本的 Xcode 可能有效，但不保证会出现一些兼容性问题。

##CocoaPods

推荐使用 CocoaPods 安装。

1. 在 Podfile 中添加 `pod 'JJHUD'`。
2. 执行 `pod install` 或 `pod update`。

##手动安装
1. 通过 `Clone or download`下载 JJHUD 文件夹内的所有内容。
2. 将 Source 内的源文件添加(拖放)到你的工程。
3. 导入 `JJHUD.swift` 。

##使用

```
JJHUD.showSuccess(text: "Login success", delay: 2.0)
```

or

```
JJHUD.showLoading()

JJHUD.hide() 
```

更多的使用用例可以看Demo工程演示以及头文件(JJHUD.swift)。

##许可

JJHUD 使用 MIT 许可证，详情可见 [LICENSE](LICENSE) 文件。

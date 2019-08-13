# facebookLogin-ios
开发语言：Swift
>iOS接入Facebook第三方登录
开发语言：Swift
 [官方文档](https://developers.facebook.com/docs/facebook-login/ios)

# 第一步
- 按照官方文档指引，创建应用并接入Facebook SDK
SDK接入可以选择`cocoapods`或者直接下载
- [注册一个Facebook开发者账号]([https://developers.facebook.com/](https://developers.facebook.com/)
)

# 第二步
- 在Facebook注册和配置应用

# 第三步
- 完成`info.plist`列表配置，`info.plist`作为源码打开，复制以下代码

```
// 000000000为自己应用的FacebookAppID与URL Schemes
//在官方文档内可生成
<key>CFBundleURLTypes</key> <array> <dict> <key>CFBundleURLSchemes</key> <array> <string>fb000000000</string> </array> </dict> </array> <key>FacebookAppID</key> <string>000000000</string> <key>FacebookDisplayName</key> <string>tblogindemo</string>
```
![](https://upload-images.jianshu.io/upload_images/13640702-528104bf43f3761e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 如要使用任何 Facebook 对话框（例如，登录、分享、应用邀请等），以便从您的应用切换至 Facebook 应用，则您应用程序的 info.plist 还必须包含以下代码
```
<key>LSApplicationQueriesSchemes</key> <array> <string>fbapi</string> <string>fb-messenger-share-api</string> <string>fbauth2</string> <string>fbshareextension</string> </array>
```

# 第四步
- 在AppDelegate中添加代码，启动时初始化 SDK，并在您执行登录或分享操作时，让 SDK 处理通过原生 Facebook 应用获得的结果。
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
//以下方法只支持iOS 9以上
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return handled
    }
```

# 第五步
- 添加Facebook登录功能
```
override func viewDidLoad() {
        let loginBtn = FBLoginButton(type: .roundedRect)
        loginBtn.center = view.center
        view.addSubview(loginBtn)
}
```
- 检验是否成功接入
点击login按钮能转跳至Facebook授权后能返回应用
![](https://upload-images.jianshu.io/upload_images/13640702-3af827fb0d321f18.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/13640702-114f7da89a94ed29.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/13640702-aeee75423183c8e6.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/13640702-e73070447348e5fe.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 如果你的按钮变成了logout，那就说明已经登录成功了

# 进阶
- 单纯登录肯定是不够了，我这里会把用户的头像以及信息显示出来
- 头像显示可以用Facebook封装好的控件`FBProfilePictureView`，将`FBProfilePictureView`的profileID设置为userID即可
```
let access = AccessToken.current
profilePictureView.profileID = access?.userID ?? ""
```

[项目demo](https://github.com/wongkaking/facebookLogin-ios)

- 因为这个demo只是用于了解Facebook登录，并没有上线，所以请大家将FacebookAppID等修改为自己项目的编号

参考

[iOS集成facebook实现自动登录](https://www.jianshu.com/p/4186c54c13b1)

尊重原创，转载请注明出处，谢谢！
未经授权禁止转载！

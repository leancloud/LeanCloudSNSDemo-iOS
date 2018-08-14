# LeanCloudSNSDemo-iOS
 
## iOS AVUser 第三方登录示例 Demo
 
 
此 Demo 以微信为例子，演示了如果使用 AuthData 登录或注册 AVUser，同时演示了如何使用 UnionID 的方式登录。

AuthData 的格式以微信为例：

```
//AuthData 格式
{
"access_token":"ACCESS_TOKEN", 
"expires_in":7200, 
"refresh_token":"REFRESH_TOKEN",
"openid":"OPENID", 
"scope":"SCOPE",
"unionid":"o6_bmasdasdsad6_2sgVt7hMZOPfL"
}

```
AuthData 需要从微信官方提供的 SDK 获取到，或者使用第三方提供的社交登录组件获取。LeanCloud 不提供获取 authData 的方法。

此 Demo 使用 Share SDK 的相关登录授权接口获取到 AuthData，然后使用此 AuthData 来演示 AVUser 的第三方登录。






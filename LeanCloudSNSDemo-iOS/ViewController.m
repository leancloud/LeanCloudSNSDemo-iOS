//
//  ViewController.m
//  LeanCloudSNSDemo-iOS
//
//  Created by Vivian on 2018/8/7.
//  Copyright © 2018年 LeanCloud. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <AVOSCloud/AVOSCloud.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    AVUser *user = [AVUser user];
    user.username = @"Tom";
    user.password =  @"123";
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 注册成功
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
        }
    }];
}
//使用 Auth Data 登录或注册 AVUser，以微信登录为例。
- (IBAction)weixinLogin:(id)sender {
    
   //此处调用 ShareSDK 的 getUserInfo 方法获取 Auth Data，用户也可从微信官方提供的 SDK 获取 Auth Data。
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         
         if (state == SSDKResponseStateSuccess)
         {
             // 由 ShareSDK 返回的数据，user.credential.rawData 即 Auth Data;
             NSLog(@"AuthData=%@",user.credential.rawData);
             
             AVUser *newUser = [AVUser user];
             AVUserAuthDataLoginOption *option = [AVUserAuthDataLoginOption new];
             option.platform = LeanCloudSocialPlatformWeiXin;
             [newUser loginWithAuthData:user.credential.rawData platformId:LeanCloudSocialPlatformWeiXin options:option callback:^(BOOL succeeded, NSError * _Nullable error) {
                 if (succeeded) {
                     NSLog(@"微信登录成功");
                     
                 }
             }];
         }else{
             NSLog(@"%@",error);
         }
     }];
}

//使用带有 Union ID 的 Auth Data 登录或注册 AVUser
- (IBAction)UnionIDLogin:(id)sender {
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         
         if (state == SSDKResponseStateSuccess)
         {
             // 由 ShareSDK 返回的数据，user.credential.rawData 即 Auth Data;
             NSLog(@"AuthData=%@",user.credential.rawData);
             
             AVUser *currentuser = [AVUser user];
             AVUserAuthDataLoginOption *option = [AVUserAuthDataLoginOption new];
             option.platform = LeanCloudSocialPlatformWeiXin;
             option.unionId = @"unionid";
             option.isMainAccount = true;
             //platformId 可自行设置，例如此处的 wxminiprogram 是标记为小程序登录，其他方式登陆 platformId 可自定义设置。
             [currentuser loginWithAuthData:user.credential.rawData platformId:@"wxminiprogram" options:option callback:^(BOOL succeeded, NSError * _Nullable error) {
                 if (succeeded) {
                     NSLog(@"登录成功");
                     
                 }
             }];
         }else{
             NSLog(@"%@",error);
         }
     }];
    
}
//将 Auth Data 绑定到现有的 AVUser。
- (IBAction)associateWeixin:(id)sender {
   
    //已经登录的用户 Tom 绑定微信
    [AVUser logInWithUsernameInBackground:@"Tom" password:@"123" block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"%@ 登录成功",user.username);
            [self tomAssociateWeixin];
        }
    }];
}
-(void)tomAssociateWeixin{
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             // 由 ShareSDK 返回的数据，user.credential.rawData 即 Auth Data;
             NSLog(@"AuthData=%@",user.credential.rawData);
             
             // LeanCloud 使用 Auth Data 登录
             AVUser * userTom = [AVUser currentUser];
             AVUserAuthDataLoginOption *option = [AVUserAuthDataLoginOption new];
             option.platform = LeanCloudSocialPlatformWeiXin;
             [userTom associateWithAuthData:user.credential.rawData platformId:LeanCloudSocialPlatformWeiXin options:option callback:^(BOOL succeeded, NSError * _Nullable error) {
                 if (succeeded) {
                     NSLog(@"绑定微信成功");
                     
                 }
             }];
         }else{
             NSLog(@"%@",error);
         }
     }];
}
@end
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "StepCountViewController.h"
@implementation AppDelegate

{
    FlutterMethodChannel* methodChannel;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    //FlutterMethodChannel 与 Flutter 之间的双向通信
    [self  methodChannelFunction];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


- (void)methodChannelFunction {
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    //创建 FlutterMethodChannel
    // flutter_and_native_101 是通信标识
    methodChannel = [FlutterMethodChannel
                     methodChannelWithName:@"flutter_and_native_ios"
                     binaryMessenger:controller];
    //设置监听
    [methodChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // TODO
        NSString *method=call.method;
        if ([method isEqualToString:@"test"]) {
         
            
            StepCountViewController *vc = [[StepCountViewController alloc]init];
            [vc getStepCountWithReslut:^(NSString * _Nonnull step) {
                NSLog(@"flutter 调用到了 ios test");
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:step?:@"没获取到值" forKey:@"message"];
                [dic setObject: [NSNumber numberWithInt:200] forKey:@"code"];
                //FlutterResult回调 发消息至 Flutter 中
                //此方法只能调用一次
                result(dic);
            }];
            
            
            
        }
    
    }];

}


@end

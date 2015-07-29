//
//  AppDelegate.m
//  邯郸规划设计院20层多功能厅
//
//  Created by wharlim on 15/7/25.
//  Copyright (c) 2015年 wharlim. All rights reserved.
//


#import "AppDelegate.h"
#import "GCDAsyncSocket.h"


#define HOST @"192.168.1.127"
#define PORT 3003

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
    NSError *error;
    [asyncSocket connectToHost:HOST onPort:PORT withTimeout:3 error:&error];
    connectState = YES;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [asyncSocket disconnect];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [asyncSocket connectToHost:HOST onPort:PORT withTimeout:3 error:nil];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





+(AppDelegate *)app{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)sendCom:(NSString *)com{
    if (![asyncSocket isConnected]) {
        NSLog(@"sendcom->disconnect");
    }
    //else {
    NSLog(@"com----->%@",com);
    [asyncSocket writeData:[com dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    // }
    
}


#pragma mark - GCDAsyncSocket delegate



- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"connected");
    if (!connectState) {
        connectState = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopAnimation" object:nil];
        NSLog(@"send the stopanimation");
    }
    NSLog(@"socket:%p,host:%@,port:%d",sock,host,port);
    [asyncSocket readDataWithTimeout:-1 tag:0];
    
}




- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"disconnect!!!");
    connectState = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startAnimation" object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{      //  新建线程等待3秒并尝试连接
        [NSThread sleepForTimeInterval:3];
        NSLog(@"nsThread sleep 2");
        dispatch_async(dispatch_get_main_queue(), ^{
            [asyncSocket connectToHost:HOST onPort:PORT withTimeout:3  error:nil];
            
        });
        
    });
    
}



- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *rev = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"receive:-->%@",rev);
    if ([rev length] == 29) {
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"RevData" object:rev];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RevData" object:nil userInfo:[NSDictionary dictionaryWithObject:rev forKey:@"rev"]];
    }
    
    [asyncSocket readDataWithTimeout:-1 tag:0];
    
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    
}


@end
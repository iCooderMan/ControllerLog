#ControllerLog

### 使用方法


```
//1. 导入头文件  

#import <asl.h>

//2. 枚举

typedef enum : NSUInteger {
    
    kEnterControllerType = 1000,
    kLeaveControllerType,
    kDeallocType,
    
} EDebugTag;


//3. 宏

#define _Flag_NSLog(fmt,...) {                                        \
do                                                                  \
{                                                                   \
NSString *str = [NSString stringWithFormat:fmt, ##__VA_ARGS__];   \
printf("%s\n",[str UTF8String]);                                  \
asl_log(NULL, NULL, ASL_LEVEL_NOTICE, "%s", [str UTF8String]);    \
}                                                                   \
while (0);                                                          \
}

#ifdef DEBUG
#define ControllerLog(fmt, ...) _Flag_NSLog((@"" fmt), ##__VA_ARGS__)
#else
#define ControllerLog(...)
#endif




//4. 生命周期

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
#ifdef DEBUG
    
    [self debugWithString:@"[➡️] Did entered to" debugTag:kEnterControllerType];
    
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    
#ifdef DEBUG
    
    [self debugWithString:@"[⛔️] Did left from" debugTag:kLeaveControllerType];
    
#endif
}

- (void)dealloc {
    
#ifdef DEBUG
    
    [self debugWithString:@"[❌] Did released the" debugTag:kDeallocType];
    
#endif
}


//5. 相关方法

#pragma mark - Debug message.
- (void)debugWithString:(NSString *)string debugTag:(EDebugTag)tag {
    
    NSDateFormatter *outputFormatter  = [[NSDateFormatter alloc] init] ;
    outputFormatter.dateFormat        = @"HH:mm:ss.SSS";
    
    NSString        *classString = [NSString stringWithFormat:@" %@ %@ [%@] ",
                                    [outputFormatter stringFromDate:[NSDate date]],
                                    string,
                                    [self class]];
    NSMutableString *flagString  = [NSMutableString string];
    
    for (int i = 0; i < classString.length; i++) {
        
        if (i == 0 || i == classString.length - 1) {
            
            [flagString appendString:@"+"];
            continue;
        }
        
        switch (tag) {
                
            case kEnterControllerType:
                [flagString appendString:@">"];
                break;
                
            case kLeaveControllerType:
                [flagString appendString:@"<"];
                break;
                
            case kDeallocType:
                [flagString appendString:@" "];
                break;
                
            default:
                break;
        }
    }
    
    NSString *showSting = [NSString stringWithFormat:@"\n%@\n%@\n%@\n", flagString, classString, flagString];
    ControllerLog(@"%@", showSting);
}

```

![控制器Log](http://git.oschina.net/uploads/images/2016/0825/165438_1c0581a5_727503.png "在这里输入图片标题")
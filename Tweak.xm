#import <UIKit/UIKit.h>
#import "MenuView.h"

extern float getSpeed();

%hook UIApplication

-(void)applicationDidFinishLaunching:(id)application{

    %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        MenuView *menu = [[MenuView alloc] init];
        [window addSubview:menu];
        
    });
}

%end


%hook CADisplayLink

-(void)setPreferredFramesPerSecond:(NSInteger)fps{
    
    float speed = getSpeed();
    
    fps = fps * speed;
    
    %orig(fps);
}

%end
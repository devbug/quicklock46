#import <AudioToolbox/AudioToolbox.h>
#import "RootViewController.h"

#import <unistd.h>

@interface quicklock46Application: UIApplication <UIApplicationDelegate> {
	UIWindow *_window;
	RootViewController *_viewController;
}
@property (nonatomic, retain) UIWindow *window;
@end

@implementation quicklock46Application
@synthesize window = _window;
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	_viewController = [[RootViewController alloc] init];
	[_window addSubview:_viewController.view];
	[_window makeKeyAndVisible];
	
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.apple.springboard.plist"];
	
	if ((dict[@"lock-unlock"] == nil || [dict[@"lock-unlock"] boolValue]) && kCFCoreFoundationVersionNumber >= 847.20) {
		// play lock sound
		AudioServicesPlaySystemSound(1100);
	}
	
	[self performSelector:@selector(exitMyself) withObject:nil afterDelay:1.0f];
}

- (void)exitMyself {
	int pid = getpid();
	kill(pid, SIGKILL);
}

- (void)dealloc {
	[_viewController release];
	[_window release];
	[super dealloc];
}
@end

// vim:ft=objc

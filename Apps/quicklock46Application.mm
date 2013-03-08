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

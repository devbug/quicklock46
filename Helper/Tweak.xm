#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AppSupport/CPDistributedMessagingCenter.h>

#import <objc/runtime.h>


@interface SBUserAgent : NSObject
+ (id)sharedUserAgent;
- (void)dimScreen:(BOOL)dim;
//{{{ iOS 6
- (void)lockAndDimDevice;
//}}}
@end

@interface SpringBoard : NSObject
- (void)lockButtonDown:(GSEventRef)event;
- (void)lockButtonUp:(GSEventRef)event;
- (void)lockDevice:(GSEventRef)event;
@end

@interface SpringBoard (NEW)
- (void)lockAndDimDevice;
@end



@class QuickLock46Helper;

static QuickLock46Helper *quicklock46Helper = nil;
static SpringBoard *g_SpringBoard = nil;


@interface QuickLock46Helper : NSObject {
	CPDistributedMessagingCenter *center;
}

- (void)shouldLockDevice:(NSString *)name userInfo:(NSDictionary *)userInfo;

@end

@implementation QuickLock46Helper

- (id)init {
	if((self = [super init])) {
		center = [[CPDistributedMessagingCenter centerNamed:@"me.devbug.quicklock46helper.center"] retain];
		[center runServerOnCurrentThread];
		[center registerForMessageName:@"SHOULDLOCKDEVICE" target:self selector:@selector(shouldLockDevice:userInfo:)];
	}
	
	return self;
}

- (void)shouldLockDevice:(NSString *)name userInfo:(NSDictionary *)userInfo {
	[g_SpringBoard lockAndDimDevice];
}

- (void)dealloc {
	[center release];
	[super dealloc];
}

@end


%group SPRINGBOARD

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
	%orig;
	
	g_SpringBoard = self;
}

%new
- (void)lockAndDimDevice {
	SBUserAgent *userAgent = [objc_getClass("SBUserAgent") sharedUserAgent];
	
	if ([userAgent respondsToSelector:@selector(lockAndDimDevice)]) {
		[userAgent lockAndDimDevice];
	}
}

%end

%end


%group QUICKLOCKAPP

%hook quicklock46Application

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	%orig;
	
	CPDistributedMessagingCenter *center = [CPDistributedMessagingCenter centerNamed:@"me.devbug.quicklock46helper.center"];
	[center sendMessageName:@"SHOULDLOCKDEVICE" userInfo:nil];
	[center release];
}

%end

%end



%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	
	if ([bundleIdentifier isEqualToString:@"com.apple.springboard"]) {
		%init(SPRINGBOARD);
		
		quicklock46Helper = [[QuickLock46Helper alloc] init];
	} else if ([bundleIdentifier isEqualToString:@"me.devbug.quicklock46"]) {
		%init(QUICKLOCKAPP);
	}
	
	[pool release];
}

int main(int argc, char **argv) {
	NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
	int ret = UIApplicationMain(argc, argv, @"quicklock46Application", @"quicklock46Application");
	[p drain];
	return ret;
}

// vim:ft=objc

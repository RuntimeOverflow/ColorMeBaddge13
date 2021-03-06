#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "SpringBoard.h"
#import "CMBIconInfo.h"

@implementation CMBIconInfo

- (CMBIconInfo *)init
{
	self = [super init];

	if (self)
	{
	}

	return self;
}

+ (CMBIconInfo *)sharedInstance
{
	static CMBIconInfo *sharedInstance = nil;

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[CMBIconInfo alloc] init];
		// Do any other initialisation stuff here
	});

	return sharedInstance;
}

- (CMBIconInfo *)getIconInfo:(id)icon
{
	CMBIconInfo *iconInfo = [[CMBIconInfo alloc] init];

	iconInfo.icon = icon;

	if ([icon isKindOfClass:NSClassFromString(@"SBApplicationIcon")])
	{
		// should be same as nodeIdentifier
		iconInfo.nodeIdentifier = [icon applicationBundleID];
		iconInfo.isApplication = YES;

		if ([icon respondsToSelector:@selector(displayName)])
		{
			iconInfo.displayName = [icon displayName];
		}
		else
		{
			LSApplicationProxy *proxy = [objc_getClass("LSApplicationProxy") applicationProxyForIdentifier:iconInfo.nodeIdentifier];

			if (proxy)
				iconInfo.displayName = [proxy localizedName];
		}
	}
	else if ([icon isKindOfClass:NSClassFromString(@"SBFolderIcon")])
	{
		// [icon nodeIdentifier] -- this selector should exist, but crashes on 9.3.3 (maybe elsewhere) with error:
		// *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[SBFolderIcon copyWithZone:]: unrecognized selector sent to instance 0x........'
		//iconInfo.nodeIdentifier = [icon nodeIdentifier];

		// just looking for uniqueness so this should suffice:
		iconInfo.nodeIdentifier = [NSString stringWithFormat:@"%p", icon];
		iconInfo.isApplication = NO;

		if ([icon respondsToSelector:@selector(displayName)])
		{
			iconInfo.displayName = [icon displayName];
		}
		else
		{
			iconInfo.displayName = [[icon folder] displayName];
		}
	}
	else
	{
		return nil;
	}

	return iconInfo;
}

- (id)realBadgeNumberOrString
{
	return [self.icon badgeNumberOrString];
}

- (id)fakeBadgeNumberOrString
{
	return [self.icon badgeNumberOrString];
}

@end

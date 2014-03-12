#import <SpringBoard/SpringBoard.h>
#import <Foundation/NSObject.h>
#import "BulletinBoard/BulletinBoard.h"

#define isiOS7 (kCFCoreFoundationVersionNumber >= 800.00)

@interface SBBulletinBannerController : NSObject
+ (SBBulletinBannerController *)sharedInstance;
- (void)observer:(id)observer addBulletin:(BBBulletinRequest *)bulletin forFeed:(int)feed;
@end


%group iOS6
%hook SBApplicationIcon

- (void)launch
{

	NSString *body = @"Helloworld";

	//stolen from caughtinflux, thanks :P
	Class bulletinBannerController = objc_getClass("SBBulletinBannerController");
	Class bulletinRequest = objc_getClass("BBBulletinRequest");

	BBBulletinRequest *request = [[[bulletinRequest alloc] init] autorelease];
	request.title =  [[self application] displayName];
	request.message = body;
	request.sectionID = [[self application] bundleIdentifier];
	request.defaultAction = [BBAction actionWithLaunchBundleID:[[self application] bundleIdentifier] callblock:nil];



	[(SBBulletinBannerController *)[bulletinBannerController sharedInstance] observer:nil addBulletin:request forFeed:2];

}
%end
%end //end iOS6 group
%group iOS7
%hook SBApplication
/*
- (void)didLaunch:(id)arg1;
- (void)didBeginLaunch:(id)arg1;
*/
- (_Bool)icon:(id)arg1 launchFromLocation:(int)arg2
{

	NSString *body = @"Helloworld";

	//stolen from caughtinflux, thanks :P
	Class bulletinBannerController = objc_getClass("SBBulletinBannerController");
	Class bulletinRequest = objc_getClass("BBBulletinRequest");

	BBBulletinRequest *request = [[[bulletinRequest alloc] init] autorelease];
	request.title =  [self  displayName];
	request.message = body;
	request.sectionID = [self bundleIdentifier];
	request.defaultAction = [BBAction actionWithLaunchBundleID:[self bundleIdentifier] callblock:nil];



	[(SBBulletinBannerController *)[bulletinBannerController sharedInstance] observer:nil addBulletin:request forFeed:2];


	return NO;
}

%end
%end //end iOS7 group
%ctor {
	%init();
	if (isiOS7) {
		%init(iOS7);
	} else {
		%init(iOS6);
	}
}

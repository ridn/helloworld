#import <SpringBoard/SpringBoard.h>
#import <Foundation/NSObject.h>
#import "BulletinBoard/BulletinBoard.h"


@interface SBBulletinBannerController : NSObject
+ (SBBulletinBannerController *)sharedInstance;
- (void)observer:(id)observer addBulletin:(BBBulletinRequest *)bulletin forFeed:(int)feed;
@end


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

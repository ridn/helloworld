#import <SpringBoard/SpringBoard.h>
#import <Foundation/NSObject.h>
#import "BulletinBoard/BulletinBoard.h"

/*
@interface BBBulletinRequest : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *sectionID;
id defaultAction;
@end

@interface BBAction : NSObject
{}
+ (id)actionWithLaunchBundleID:(id)arg1 callblock:(id)arg2;
- (id)description;
- (id)bundleID;
@end
*/
@interface SBBulletinBannerController : NSObject
+ (SBBulletinBannerController *)sharedInstance;
- (void)observer:(id)observer addBulletin:(BBBulletinRequest *)bulletin forFeed:(int)feed;
@end


%hook SBApplicationIcon

- (void)launch
{

	NSString *body = @"Helloworld";

	Class bulletinBannerController = objc_getClass("SBBulletinBannerController");
	Class bulletinRequest = objc_getClass("BBBulletinRequest");
		
	BBBulletinRequest *request = [[[bulletinRequest alloc] init] autorelease];
	request.title =  [[self application] displayName];
	request.message = body;
	request.sectionID = [[self application] bundleIdentifier];
	//request.defaultAction = nil;
	request.defaultAction = [BBAction actionWithLaunchBundleID:[[self application] bundleIdentifier] callblock:nil];



	[(SBBulletinBannerController *)[bulletinBannerController sharedInstance] observer:nil addBulletin:request forFeed:2];

}

%end
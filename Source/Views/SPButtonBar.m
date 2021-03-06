//
//  SPButtonBar.m
//  sequel-pro
//
//  Created by Max Lohrmann on 16.07.18.
//  Copyright (c) 2018 Max Lohrmann. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//
//  More info at <https://github.com/sequelpro/sequelpro>

#import "SPButtonBar.h"
#import "SPOSInfo.h"

static void init(SPButtonBar *obj);

@interface SPButtonBar ()

- (BOOL)isInDarkMode;

@end

@implementation SPButtonBar

@synthesize systemColorOfName;

+ (void)initialize
{
}

- (instancetype)init
{
	[NSException raise:NSInternalInconsistencyException format:@"%s is not a valid initializer for class!",__func__];
	return nil; // compiler hint
}

- (instancetype)initWithFrame:(NSRect)frameRect //designated initializer of super
{
	if(self = [super initWithFrame:frameRect]) {
		init(self);
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder //designated initializer of super
{
	if(self = [super initWithCoder:decoder]) {
		init(self);
	}
	return self;
}

void init(SPButtonBar *obj)
{
	obj->lightImage = [NSImage imageNamed:@"button_bar_spacer"];
	obj->darkImage  = [NSImage imageNamed:@"button_bar_spacer_dark"];
}


- (BOOL)isInDarkMode
{
	if (@available(macOS 10.14, *)) {
		NSString *match = [[self effectiveAppearance] bestMatchFromAppearancesWithNames:@[NSAppearanceNameAqua, NSAppearanceNameDarkAqua]];
		if ([NSAppearanceNameDarkAqua isEqualToString:match]) {
			return YES;
		}
	}
	return NO;
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSImage *img = ([self isInDarkMode] ? darkImage : lightImage);
	NSRect drawFrame = [self bounds];
	drawFrame.origin.x = dirtyRect.origin.x;
	drawFrame.size.width = dirtyRect.size.width;
	[img drawInRect:drawFrame fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0];
}

@end

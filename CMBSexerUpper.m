#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CMBSexerUpper.h"
#import "CMBPreferences.h"
#import "external/ColorBadges/ColorBadges.h"
#import "external/LEColorPicker/LEColorPicker.h"
#import "external/ColorCube/CCColorCube.h"
#import "external/Colours/Colours.h"
#import "external/Chameleon/Chameleon.h"

#define COLORBADGES_CLASS objc_getClass("ColorBadges")

@implementation CMBSexerUpper

- (CMBSexerUpper *)init
{
	self = [super init];

	if (self)
	{
	}

	return self;
}

+ (CMBSexerUpper *)sharedInstance
{
	static CMBSexerUpper *sharedInstance = nil;

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[CMBSexerUpper alloc] init];
		// Do any other initialisation stuff here
	});

	return sharedInstance;
}

- (CGFloat)getBrightnessForColorUsingRGB:(UIColor *)color
{
	CGColorRef colorref = [color CGColor];

	int numComponents = CGColorGetNumberOfComponents(colorref);
	const CGFloat *components = CGColorGetComponents(colorref);

	CGFloat brightness = 0;

	if (2 == numComponents)
		brightness = ((components[0] * 299) + (components[0] * 587) + (components[0] * 114)) / 1000;
	else if (4 == numComponents)
		brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000;

	return brightness;
}

- (CGFloat)getNormalizedBrightnessUsingCIELAB:(UIColor *)backgroundColor
{
	NSDictionary *colorDict = [backgroundColor CIE_LabDictionary];
	NSNumber *L = colorDict[kColoursCIE_L];
	CGFloat normalizedBrightness = 10 * [L doubleValue];

	return normalizedBrightness;
}

- (CGFloat)getNormalizedBrightnessUsingRGB:(UIColor *)backgroundColor
{
	CGFloat backgroundColorBrightness = [self getBrightnessForColorUsingRGB:backgroundColor];
	CGFloat normalizedBrightness = backgroundColorBrightness * 1000;

	return normalizedBrightness;
}

- (CGFloat)getNormalizedBrightness:(UIColor *)color
{
	CGFloat normalizedBrightness = 0.0;

	switch ([[CMBPreferences sharedInstance] colorSpaceType])
	{
		case kColorSpaceRGB:
			return [self getNormalizedBrightnessUsingRGB:color];
			break;

		case kColorSpaceCIELAB:
			return [self getNormalizedBrightnessUsingCIELAB:color];
			break;
	}

	return normalizedBrightness;
}

- (UIColor *)getForegroundColorByBrightnessThreshold:(UIColor *)backgroundColor
{
	CGFloat normalizedBrightness = [self getNormalizedBrightness:backgroundColor];

	NSInteger brightnessThreshold = [[CMBPreferences sharedInstance] brightnessThreshold];

/*
	CGFloat whiteDistance = [backgroundColor distanceFromColor:REAL_WHITE_COLOR type:ColoursColorDistanceCIE2000];
	CGFloat blackDistance = [backgroundColor distanceFromColor:REAL_BLACK_COLOR type:ColoursColorDistanceCIE2000];
*/

	if (normalizedBrightness > brightnessThreshold)
		return REAL_BLACK_COLOR;

	return REAL_WHITE_COLOR;
}

- (UIColor *)shadeColorUsingRGB:(UIColor *)color toNormalizedBrightness:(CGFloat)targetBrightness
{
	CGFloat r, g, b, a;

	CGFloat originalBrightness = [self getNormalizedBrightnessUsingRGB:color];

	[color getRed:&r green:&g blue:&b alpha:&a];

	CGFloat x = 1.0 - (targetBrightness / originalBrightness);

	UIColor *shadedColor = [UIColor colorWithRed:r*(1.0-x) green:g*(1.0-x) blue:b*(1.0-x) alpha:a];

	return shadedColor;
}

- (UIColor *)tintColorUsingRGB:(UIColor *)color toNormalizedBrightness:(CGFloat)targetBrightness
{
	CGFloat r, g, b, a;

	CGFloat originalBrightness = [self getNormalizedBrightnessUsingRGB:color];

	[color getRed:&r green:&g blue:&b alpha:&a];

	CGFloat x = (targetBrightness - originalBrightness) / (1000.0 - originalBrightness);

	UIColor *tintedColor = [UIColor colorWithRed:r+x*(1.0-r) green:g+x*(1.0-g) blue:b+x*(1.0-b) alpha:a];

	return tintedColor;
}

- (UIColor *)shadeColorUsingCIELAB:(UIColor *)color toNormalizedBrightness:(CGFloat)targetBrightness
{
	NSDictionary *colorDict = [color CIE_LabDictionary];

	NSMutableDictionary *newColorDict = [colorDict mutableCopy];
	UIColor *shadedColor;

	CGFloat targetL = targetBrightness / 10.0;

	// create new color with target L
	newColorDict[kColoursCIE_L] = @(targetL);
	shadedColor = [UIColor colorFromCIE_LabDictionary:newColorDict];

	// read back color and check L
	NSDictionary *shadedColorDict = [shadedColor CIE_LabDictionary];
	NSNumber *shadedL = shadedColorDict[kColoursCIE_L];
	CGFloat adjustedL = targetL;

	// if L still too high, keep reducing it slightly
	while (([shadedL doubleValue] >= targetL) && (adjustedL > 0.0))
	{
		adjustedL -= 0.1;

		newColorDict[kColoursCIE_L] = @(adjustedL);
		shadedColor = [UIColor colorFromCIE_LabDictionary:newColorDict];

		shadedColorDict = [shadedColor CIE_LabDictionary];
		shadedL = shadedColorDict[kColoursCIE_L];
	}

	return shadedColor;
}

- (UIColor *)tintColorUsingCIELAB:(UIColor *)color toNormalizedBrightness:(CGFloat)targetBrightness
{
	NSDictionary *colorDict = [color CIE_LabDictionary];

	NSMutableDictionary *newColorDict = [colorDict mutableCopy];
	UIColor *tintedColor;

	CGFloat targetL = targetBrightness / 10.0;

	// create new color with target L
	newColorDict[kColoursCIE_L] = @(targetL);
	tintedColor = [UIColor colorFromCIE_LabDictionary:newColorDict];

	// read back color and check L
	NSDictionary *tintedColorDict = [tintedColor CIE_LabDictionary];
	NSNumber *tintedL = tintedColorDict[kColoursCIE_L];
	CGFloat adjustedL = targetL;

	// if L still too low, keep increasing it slightly
	while (([tintedL doubleValue] <= targetL) && (adjustedL < 100.0))
	{
		adjustedL += 0.1;

		newColorDict[kColoursCIE_L] = @(adjustedL);
		tintedColor = [UIColor colorFromCIE_LabDictionary:newColorDict];

		tintedColorDict = [tintedColor CIE_LabDictionary];
		tintedL = tintedColorDict[kColoursCIE_L];
	}

	return tintedColor;
}

- (UIColor *)shadeColor:(UIColor *)color toNormalizedBrightness:(CGFloat)targetBrightness
{
	UIColor *shadedColor = nil;

	switch ([[CMBPreferences sharedInstance] colorSpaceType])
	{
		case kColorSpaceRGB:
			shadedColor = [self shadeColorUsingRGB:color toNormalizedBrightness:targetBrightness];
			break;

		case kColorSpaceCIELAB:
			shadedColor = [self shadeColorUsingCIELAB:color toNormalizedBrightness:targetBrightness];
			break;
	}

	if (!shadedColor)
		return color;

	return shadedColor;
}

- (UIColor *)tintColor:(UIColor *)color toNormalizedBrightness:(CGFloat)targetBrightness
{
	UIColor *tintedColor = nil;

	switch ([[CMBPreferences sharedInstance] colorSpaceType])
	{
		case kColorSpaceRGB:
			tintedColor = [self tintColorUsingRGB:color toNormalizedBrightness:targetBrightness];
			break;

		case kColorSpaceCIELAB:
			tintedColor = [self tintColorUsingCIELAB:color toNormalizedBrightness:targetBrightness];
			break;
	}

	if (!tintedColor)
		return color;

	return tintedColor;
}

- (UIColor *)shadeColorToBrightnessThreshold:(UIColor *)color
{
	CGFloat normalizedBrightness = [self getNormalizedBrightness:color];

	NSInteger brightnessThreshold = [[CMBPreferences sharedInstance] brightnessThreshold];

	if (normalizedBrightness > brightnessThreshold)
		return [self shadeColor:color toNormalizedBrightness:brightnessThreshold - 1.0];

	return color;
}

- (UIColor *)tintColorToBrightnessThreshold:(UIColor *)color
{
	CGFloat normalizedBrightness = [self getNormalizedBrightness:color];

	NSInteger brightnessThreshold = [[CMBPreferences sharedInstance] brightnessThreshold];

	if (normalizedBrightness < brightnessThreshold)
		return [self tintColor:color toNormalizedBrightness:brightnessThreshold + 1.0];

	return color;
}

- (UIColor *)adjustBackgroundColorByPreference:(UIColor *)color
{
	switch ([[CMBPreferences sharedInstance] badgeColorAdjustmentType])
	{
		case kNoAdjustment:
			return color;
			break;

		case kShadeForWhiteText:
			return [self shadeColorToBrightnessThreshold:color];
			break;

		case kTintForBlackText:
			return [self tintColorToBrightnessThreshold:color];
			break;
	}

	return color;
}

- (UIColor *)inverseColor:(UIColor *)color
{
	CGFloat r, g, b, a;

	[color getRed:&r green:&g blue:&b alpha:&a];

	UIColor *inverseColor = [UIColor colorWithRed:(1.0-r) green:(1.0-g) blue:(1.0-b) alpha:a];

	return inverseColor;
}

- (UIColor *)adjustAppBadgeBackgroundColorByPreference:(UIColor *)color
{
	switch ([[CMBPreferences sharedInstance] appBadgeBackgroundAdjustmentType])
	{
		case kABBA_None:
			return color;
			break;

		case kABBA_Shade:
			return [self shadeColorByBrightnessFactor:color factor:1.0 - SHADE_PERCENTAGE];
			break;

		case kABBA_Tint:
			return [self tintColorByBrightnessFactor:color factor:1.0 + TINT_PERCENTAGE];
			break;

		case kABBA_Inverse:
			return [self inverseColor:color];
			break;

		case kABBA_Complementary:
			return [color complementaryColor];
			break;
	}

	return color;
}

- (UIColor *)adjustAppBadgeForegroundColorByPreference:(UIColor *)color
{
	switch ([[CMBPreferences sharedInstance] appBadgeForegroundAdjustmentType])
	{
		case kABFA_None:
			return color;
			break;

		case kABFA_Shade:
			return [self shadeColorByBrightnessFactor:color factor:1.0 - SHADE_PERCENTAGE];
			break;

		case kABFA_Tint:
			return [self tintColorByBrightnessFactor:color factor:1.0 + TINT_PERCENTAGE];
			break;

		case kABFA_Inverse:
			return [self inverseColor:color];
			break;

		case kABFA_Complementary:
			return [color complementaryColor];
			break;
	}

	return color;
}

- (UIColor *)shadeColorByBrightnessFactor:(UIColor *)color factor:(double)factor
{
	CGFloat normalizedBrightness = [self getNormalizedBrightness:color];

	CGFloat targetBrightness = fmaxf(normalizedBrightness * factor, 1.0);

	return [self shadeColor:color toNormalizedBrightness:targetBrightness];
}

- (UIColor *)tintColorByBrightnessFactor:(UIColor *)color factor:(double)factor
{
	CGFloat normalizedBrightness = [self getNormalizedBrightness:color];

	CGFloat targetBrightness = fminf(normalizedBrightness * factor, NORMALIZED_BRIGHTNESS_SCALE - 1.0);

	return [self tintColor:color toNormalizedBrightness:targetBrightness];
}

- (UIColor *)adjustBorderColorByPreference:(UIColor *)color
{
	switch ([[CMBPreferences sharedInstance] badgeBorderType])
	{
		case kBB_ShadedBadgeBackgroundColor:
			return [self shadeColorByBrightnessFactor:color factor:1.0 - SHADE_PERCENTAGE];
			break;

		case kBB_TintedBadgeBackgroundColor:
			return [self tintColorByBrightnessFactor:color factor:1.0 + TINT_PERCENTAGE];
			break;
	}

	return color;
}

/*
- (void)saveImage:(UIImage *)image withName:(NSString *)name andPostfix:(NSString *)postfix
{
	return;

	static NSInteger imageCount = 1;

	NSString *pngFile = [NSString stringWithFormat:@"/tmp/cmb/%@-%@-%03ld.png", name, postfix, (long)imageCount];

	[UIImagePNGRepresentation(image) writeToFile:pngFile atomically:YES];

	imageCount++;
}

- (UIImage *)getSubImageFrom:(UIImage *)img withRect:(CGRect)rect
{
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();

	// translated rectangle for drawing sub image
	CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, img.size.width, img.size.height);

	// clip to the bounds of the image context
	// not strictly necessary as it will get clipped anyway?
	CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));

	// draw image
	[img drawInRect:drawRect];

	// grab image
	UIImage *subImage = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();

	return subImage;
}

- (UIImage *)cropMiddleOfImage:(UIImage *)image withFactor:(CGFloat)factor forApp:(NSString *)app
{
//	[self saveImage:image withName:app andPostfix:@""];

	// crop image
	CGFloat cropSize = factor * fminf(image.size.width, image.size.height);
	CGFloat edgeSize = (fminf(image.size.width, image.size.height) - cropSize) / 2.0f;

	CGRect middle = CGRectMake(edgeSize, edgeSize, cropSize, cropSize);
	UIImage *croppedImage = [self getSubImageFrom:image withRect:middle];

//	[self saveImage:croppedImage withName:app andPostfix:@"-cropped"];

	return croppedImage;
}
*/

- (CMBColorInfo *)swapColorsIfBackgroundIsBright:(CMBColorInfo *)colors
{
	CMBColorInfo *badgeColors = [[CMBColorInfo sharedInstance] colorInfoWithBackgroundColor:colors.backgroundColor andForegroundColor:colors.foregroundColor];

	NSDictionary *backgroundColorDict = [colors.backgroundColor CIE_LabDictionary];
	NSNumber *backgroundL = backgroundColorDict[kColoursCIE_L];

	NSDictionary *foregroundColorDict = [colors.foregroundColor CIE_LabDictionary];
	NSNumber *foregroundL = foregroundColorDict[kColoursCIE_L];

	double foregroundBrightness = [foregroundL doubleValue];
	double backgroundBrightness = [backgroundL doubleValue];

	if ((backgroundBrightness > foregroundBrightness) && (backgroundBrightness > 80) && (foregroundBrightness > 10))
	{
		badgeColors.backgroundColor = colors.foregroundColor;
		badgeColors.foregroundColor = colors.backgroundColor;
	}

	return badgeColors;
}

- (CMBColorInfo *)getColorsUsingLEColorPicker:(UIImage *)image
{
	LEColorPicker *colorPicker = [[LEColorPicker alloc] init];
	LEColorScheme *colorScheme = [colorPicker colorSchemeFromImage:image];

	CMBColorInfo *badgeColors = [[CMBColorInfo sharedInstance] colorInfoWithBackgroundColor:[colorScheme backgroundColor] andForegroundColor:[colorScheme primaryTextColor]];

	// FIXME: testing
	badgeColors = [self swapColorsIfBackgroundIsBright:badgeColors];

//	[colorPicker release];

	return badgeColors;
}

- (CMBColorInfo *)getColorsUsingChameleon:(UIImage *)image
{
	NSArray *backgroundColors = [NSArray arrayOfColorsFromImage:image withFlatScheme:NO];

	// find a background color

	UIColor *backgroundColor = nil;
	UIColor *foregroundColor = nil;

	// default to first color returned
	if ([backgroundColors count] >= 1)
		backgroundColor = [backgroundColors objectAtIndex:0];

	// now look for a more colorful choice
	for (UIColor *thisColor in backgroundColors)
	{
		if (![self colorSeemsGrey:thisColor])
		{
			backgroundColor = thisColor;
			break;
		}
	}

	CMBColorInfo *badgeColors = [[CMBColorInfo sharedInstance] colorInfoWithBackgroundColor:backgroundColor andForegroundColor:foregroundColor];

	return badgeColors;
}

- (UIColor *)randomColor
{
	UIColor *randomColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f];

	return randomColor;
}

- (CMBColorInfo *)getColorsUsingRandom
{
	UIColor *backgroundColor = [self randomColor];
	UIColor *foregroundColor = [self randomColor];

	CMBColorInfo *badgeColors = [[CMBColorInfo sharedInstance] colorInfoWithBackgroundColor:backgroundColor andForegroundColor:foregroundColor];

	return badgeColors;
}

- (BOOL)colorSeemsGrey:(UIColor *)color
{
	CGFloat r, g, b, a;
	CGFloat steps = 255.0;
	NSInteger epsilon = 25;

	[color getRed:&r green:&g blue:&b alpha:&a];

	NSInteger red = (NSInteger)(steps * r);
	NSInteger green = (NSInteger)(steps * g);
	NSInteger blue = (NSInteger)(steps * b);

	if ((ABS(red - green) <= epsilon) && (ABS(green - blue) <= epsilon) && (ABS(blue - red) <= epsilon))
		return YES;

	return NO;
}

- (CMBColorInfo *)getColorsUsingCCColorCube:(UIImage *)image
{
	CCColorCube *colorCube = [[CCColorCube alloc] init];

	NSArray *backgroundColors;
	NSArray *foregroundColors;

	backgroundColors = [colorCube extractColorsFromImage:image flags:CCAvoidWhite|CCAvoidBlack];
	// FIXME: testing
	foregroundColors = [colorCube extractColorsFromImage:image flags:CCAvoidWhite|CCAvoidBlack];
//	foregroundColors = [colorCube extractColorsFromImage:image flags:0];

	if (0 == [backgroundColors count])
	{
		// hmm
		backgroundColors = [colorCube extractColorsFromImage:image flags:CCAvoidWhite];
	}

	if (0 == [backgroundColors count])
	{
		// hmm
		backgroundColors = [colorCube extractColorsFromImage:image flags:CCAvoidBlack];
	}

	if (0 == [backgroundColors count])
	{
		// Hmm
		backgroundColors = foregroundColors;
	}

	// find a background color

	UIColor *backgroundColor = nil;
	UIColor *foregroundColor = nil;

	// default to first color returned
	if ([backgroundColors count] >= 1)
		backgroundColor = [backgroundColors objectAtIndex:0];

	// now look for a more colorful choice
	for (UIColor *thisColor in backgroundColors)
	{
		if (![self colorSeemsGrey:thisColor])
		{
			backgroundColor = thisColor;
			break;
		}
	}

	if (backgroundColor)
	{
		// now try to find a contrasting foreground color
		NSDictionary *backgroundColorDict = [backgroundColor CIE_LabDictionary];
		NSNumber *backgroundL = backgroundColorDict[kColoursCIE_L];
		double backgroundBrightness = [backgroundL doubleValue];

		for (UIColor *thisColor in foregroundColors)
		{
			NSDictionary *thisColorDict = [thisColor CIE_LabDictionary];
			NSNumber *thisL = thisColorDict[kColoursCIE_L];
			double thisBrightness = [thisL doubleValue];

			// 0 ... 100
			CGFloat distance = [thisColor distanceFromColor:backgroundColor type:ColoursColorDistanceCIE2000];

			// wild guess
			if ((fabs(backgroundBrightness - thisBrightness) > 49.0) && (distance > 49.0))
			{
				foregroundColor = thisColor;
				break;
			}

		}
	}

	CMBColorInfo *badgeColors = [[CMBColorInfo sharedInstance] colorInfoWithBackgroundColor:backgroundColor andForegroundColor:foregroundColor];

//	[colorCube release];

	return badgeColors;
}

- (UIColor *)getBooverDominantColor:(UIImage *)image
{
	NSUInteger red = 0;
	NSUInteger green = 0;
	NSUInteger blue = 0;

	struct pixel { unsigned char r, g, b, a; };

	struct pixel* pixels = (struct pixel*) calloc(1, image.size.width * image.size.height * sizeof(struct pixel));

	if (pixels != nil)
	{
		CGContextRef context = CGBitmapContextCreate((void*) pixels, image.size.width, image.size.height, 8, image.size.width * 4, CGImageGetColorSpace(image.CGImage), kCGImageAlphaPremultipliedLast);

		if (context != NULL)
		{
			// Draw the image in the bitmap

			CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);

			// Now that we have the image drawn in our own buffer, we can loop over the pixels to
			// process it. This simple case simply counts all pixels that have a pure red component.

			// There are probably more efficient and interesting ways to do this. But the important
			// part is that the pixels buffer can be read directly.

			NSUInteger numberOfPixels = image.size.width * image.size.height;
			NSUInteger pixelsToOmit = 0;
			for (int i=0; i<numberOfPixels; i++)
			{
				NSUInteger threshhold = 210;

				if(pixels[i].r > threshhold)
				{
					if(pixels[i].g > threshhold)
					{
						if(pixels[i].b > threshhold)
						{
							pixelsToOmit++;
							continue;
						}
					}
				}

				red += pixels[i].r;
				green += pixels[i].g;
				blue += pixels[i].b;
			}

			numberOfPixels -= pixelsToOmit;

			red /= numberOfPixels;
			green /= numberOfPixels;
			blue /= numberOfPixels;

			CGContextRelease(context);
		}

		free(pixels);
	}

	return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}

- (CMBColorInfo *)getColorsUsingBooverAlgorithm:(UIImage *)image
{
	UIColor *backgroundColor = [self getBooverDominantColor:image];

	CMBColorInfo *badgeColors = [[CMBColorInfo sharedInstance] colorInfoWithBackgroundColor:backgroundColor andForegroundColor:nil];

	return badgeColors;
}

- (CMBColorInfo *)getColorsUsingColorBadges:(UIImage *)image
{
	if (!COLORBADGES_CLASS)
		return nil;

	if (![COLORBADGES_CLASS respondsToSelector:@selector(sharedInstance)])
		return nil;

	if (![[COLORBADGES_CLASS sharedInstance] respondsToSelector:@selector(colorForImage:)])
		return nil;

	int badgeColor = [[COLORBADGES_CLASS sharedInstance] colorForImage:image];

	UIColor *backgroundColor = UIColorFromRGB(badgeColor);

	CMBColorInfo *badgeColors = [[CMBColorInfo sharedInstance] colorInfoWithBackgroundColor:backgroundColor andForegroundColor:nil];

	return badgeColors;
}

- (int)DRGBFromUIColor:(UIColor *)color
{
	CGFloat r, g, b, a;
	int D, R, G, B, drgb;

	[color getRed:&r green:&g blue:&b alpha:&a];

	// simple conversion from extended SRGB
	// (seems to match CGColorSpace conversion values)

	r = fmaxf(0.0, fminf(1.0, r));
	g = fmaxf(0.0, fminf(1.0, g));
	b = fmaxf(0.0, fminf(1.0, b));

	CGFloat normalizedBrightness = [self getNormalizedBrightness:color];

	NSInteger brightnessThreshold = [[CMBPreferences sharedInstance] brightnessThreshold];

	// D = is dark color flag, carried in extra bits of int
	D = (normalizedBrightness <= brightnessThreshold) ? 1 : 0;

	R = (int)round(255.0 * r);
	G = (int)round(255.0 * g);
	B = (int)round(255.0 * b);

	drgb = ((D & 0xFF) << 24) | ((R & 0xFF) << 16) | ((G & 0xFF) << 8) | (B & 0xFF);

	return drgb;
}

@end

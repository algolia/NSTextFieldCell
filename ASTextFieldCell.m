// Copyright (C) 2012 Julien Lemoine. All rights reserved.
// Contact: contact (at) algolia.com
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.
//

#import "ASTextFieldCell.h"

@implementation ASTextFieldCell

@synthesize highlightedTextFont;
@synthesize highlightedTextColor;
@synthesize subTitle;
@synthesize subTitleTextColor;
@synthesize subTitleTextFont;
@synthesize subTitleHighlightedTextColor;
@synthesize subTitleHighlightedTextFont;
@synthesize offsetBetweenLines;
@synthesize leftMargin;

-(id) init
{
    self = [super init];
    if (self != nil) {
        self.highlightedTextColor = [NSColor colorWithCalibratedRed:0.21f green:0.69f blue:1.0f alpha:1.0f];
        self.subTitleHighlightedTextColor = [NSColor colorWithCalibratedRed:0.21f green:0.69f blue:1.0f alpha:1.0f];
        self.subTitleTextColor = [NSColor grayColor];
        
        self.font = [NSFont fontWithName:@"Helvetica" size:16];
        self.highlightedTextFont = [NSFont fontWithName:@"Helvetica" size:16];
        
        self.subTitleTextFont = [NSFont fontWithName:@"Helvetica" size:12];
        self.subTitleHighlightedTextFont = [NSFont fontWithName:@"Helvetica" size:12];
        offsetBetweenLines = 0.0;
        leftMargin = 5.0;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    ASTextFieldCell* newCopy = [[ASTextFieldCell allocWithZone:zone] init];
    newCopy.highlightedTextFont = self.highlightedTextFont;
    newCopy.highlightedTextColor = self.highlightedTextColor;
    newCopy.subTitle = self.subTitle;
    newCopy.subTitleTextFont = self.subTitleTextFont;
    newCopy.subTitleTextColor = self.subTitleTextColor;
    newCopy.subTitleHighlightedTextFont = self.subTitleHighlightedTextFont;
    newCopy.subTitleHighlightedTextColor = self.subTitleHighlightedTextColor;
    newCopy.leftMargin = self.leftMargin;
    newCopy.offsetBetweenLines = self.offsetBetweenLines;
    return newCopy;
}

-(void) dealloc
{
    [highlightedTextFont release];
    [highlightedTextColor release];
    [subTitle release];
    [subTitleTextColor release];
    [subTitleTextFont release];
    [subTitleHighlightedTextColor release];
    [subTitleHighlightedTextFont release];
    [super dealloc];
}

-(void) drawString:(NSString*)str idx:(NSUInteger)idx length:(NSUInteger)length rect:(CGRect)rect bold:(BOOL)bold font:(NSFont*)font highlightedFont:(NSFont*)highlightedFont color:(NSColor*)color highlightedColor:(NSColor*)highlightedColor
{
    if (length > 0) {
        NSString* toDisplay = [str substringWithRange:NSMakeRange(idx, length)];
        
        NSColor* currentColor = color;
        if (bold && highlightedColor != nil)
            currentColor = highlightedColor;
        NSFont* currentFont = font;
        if (bold && highlightedFont != nil)
            currentFont = highlightedFont;
        NSDictionary *attributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    currentFont, NSFontAttributeName,
                                    currentColor, NSForegroundColorAttributeName, nil];
        [toDisplay drawInRect:CGRectMake(rect.origin.x + offset, rect.origin.y, rect.size.width, rect.size.height) withAttributes:attributes];
        NSRect s = [toDisplay boundingRectWithSize:rect.size options:NSStringDrawingOneShot attributes:attributes];
        offset += s.size.width;
    }
}

BOOL containsString(NSString* src, NSUInteger idx, const char* toSearch)
{
    NSUInteger count = [src length];
    for (NSUInteger i = 0; toSearch[i] != 0; ++i) {
        NSUInteger srcIdx = idx + i;
        if (srcIdx >= count)
            return NO;
        unichar c = [src characterAtIndex:srcIdx];
        if (c != toSearch[i] && c != toupper(toSearch[i]))
            return NO;
    }
    return YES;
}

- (void) drawText:(NSString*)text rect:(NSRect)rect font:(NSFont*)font highlightedFont:(NSFont*)highlightedFont color:(NSColor*)color highlightedColor:(NSColor*)highlightedColor
{
    BOOL isBold = NO;
    
    offset = 0;
    if (text != nil) {
        NSUInteger prevPos = 0;
        NSUInteger count = [text length];
        for (NSUInteger i = 0; i < count; ) {
            if ([text characterAtIndex:i] == '<') {
                if (containsString(text, i, "<b>")) {
                    [self drawString:text idx:prevPos length:(i - prevPos) rect:rect bold:isBold font:font highlightedFont:highlightedFont color:color highlightedColor:highlightedColor];
                    i += 3;
                    prevPos = i;
                    isBold = YES;
                } else if (containsString(text, i, "</b>")) {
                    [self drawString:text idx:prevPos length:(i - prevPos) rect:rect bold:isBold font:font highlightedFont:highlightedFont color:color highlightedColor:highlightedColor];
                    i += 4;
                    prevPos = i;
                    isBold = NO;
                } else {
                    ++i;
                }
            } else {
                ++i;
            }
        }
        if (prevPos < count) {
            [self drawString:text idx:prevPos length:(count - prevPos) rect:rect bold:isBold font:font highlightedFont:highlightedFont color:color highlightedColor:highlightedColor];
        }
    }
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView*)controlView
{
    [self drawText:self.title rect:NSMakeRect(cellFrame.origin.x + leftMargin, cellFrame.origin.y, cellFrame.size.width - leftMargin, cellFrame.size.height) font:self.font highlightedFont:self.highlightedTextFont color:self.textColor highlightedColor:self.highlightedTextColor];
    if (self.subTitle != nil) {
        CGFloat fontOffset = 1.5 * [self.font capHeight] + offsetBetweenLines;
        [self drawText:self.subTitle rect:NSMakeRect(cellFrame.origin.x + leftMargin, cellFrame.origin.y + fontOffset, cellFrame.size.width - leftMargin, cellFrame.size.height - fontOffset) font:self.subTitleTextFont highlightedFont:self.subTitleHighlightedTextFont color:self.subTitleTextColor highlightedColor:self.subTitleHighlightedTextColor];
    }
}

@end

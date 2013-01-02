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

#import <Cocoa/Cocoa.h>

/**
 * This class interprets the <b></b> tags in the title and subTitle attribute of Label.
 *
 * The label use 2 differents fonts and 2 differents colors to render title and subTitle attributes.
 * 
 * Here is the behavior:
 * - Parts of title without tags are rendered with textColor and font;
 * - Parts of title between <b></b> tags are rendered with highligtedTextColor and highligtedTextFont;
 * - Parts of subTitle without tags are rendered with subTitleTextColor and subTitleTextFont;
 * - Parts of subTitle between <b></b> tags are rendered with subTitleHighlightedTextColor and subTitleHighlightedTextFont;
 */
@interface ASTextFieldCell : NSTextFieldCell<NSCopying>
{
    NSFont* highlightedTextFont;
    NSColor* highlightedTextColor;
    
    NSUInteger offset;
    
    NSString *subTitle;
    NSFont* subTitleTextFont;
    NSColor* subTitleTextColor;
    NSFont* subTitleHighlightedTextFont;
    NSColor* subTitleHighlightedTextColor;
    
    CGFloat offsetBetweenLines;
    CGFloat leftMargin;
}
@property (retain, nonatomic) NSFont* highlightedTextFont;
@property (retain, nonatomic) NSColor* highlightedTextColor;

@property (retain, nonatomic) NSString* subTitle;
@property (retain, nonatomic) NSFont* subTitleTextFont;
@property (retain, nonatomic) NSColor* subTitleTextColor;
@property (retain, nonatomic) NSFont* subTitleHighlightedTextFont;
@property (retain, nonatomic) NSColor* subTitleHighlightedTextColor;

@property CGFloat offsetBetweenLines;
@property CGFloat leftMargin;

@end

//
//  IBButton.h
//  InnerBand
//
//  InnerBand - The iOS Booster!
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <UIKit/UIKit.h>
#import "ARCMacros.h"

typedef enum {
	IBButtonTypeGlossy,
	IBButtonTypeSoft,
	IBButtonTypeFlat
} IBButtonType;

@interface IBButton : UIButton {
	IBButtonType _type;
	float _cornerRadius;
	UIColor *_color;
	UIColor *_shineColor;
	UIColor *_borderColor;
	int _borderSize;
}

@property(nonatomic, SAFE_ARC_PROP_RETAIN) UIColor *color;
@property(nonatomic, SAFE_ARC_PROP_RETAIN) UIColor *shineColor;
@property(nonatomic, SAFE_ARC_PROP_RETAIN) UIColor *borderColor;
@property(nonatomic, assign) int borderSize;
@property(nonatomic, assign) IBButtonType type;
@property(nonatomic, assign) float cornerRadius;

+(IBButton*) glossButtonWithTitle:(NSString*)title color:(UIColor*)color;
+(IBButton*) softButtonWithTitle:(NSString*)title color:(UIColor*)color;
+(IBButton*) flatButtonWithTitle:(NSString*)title color:(UIColor*)color;

@end

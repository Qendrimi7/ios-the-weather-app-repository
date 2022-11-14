//
//  UISheetPresentationControllerDetent+Private.h
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISheetPresentationControllerDetent (Private)
+ (UISheetPresentationControllerDetent *)_detentWithIdentifier:(NSString *)identifier constant:(CGFloat)constant;
@end

NS_ASSUME_NONNULL_END

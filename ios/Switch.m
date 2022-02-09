//
//  Switch.m
//  documentDeneme
//
//  Created by Alper Salık on 7.02.2022.
//

#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"
@interface RCT_EXTERN_MODULE(Switch, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(isOn  , BOOL)
@end

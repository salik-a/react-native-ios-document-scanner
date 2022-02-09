//
//  Torch.m
//  documentDeneme
//
//  Created by Alper Salık on 7.02.2022.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"
@interface RCT_EXTERN_MODULE(Torch, RCTEventEmitter)
RCT_EXTERN_METHOD(open)
RCT_EXTERN_METHOD(getTorchImageData: (RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(getTorchImageText: (RCTResponseSenderBlock)callback)
@end

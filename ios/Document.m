//
//  Document.m
//  documentDeneme
//
//  Created by Alper Salık on 7.02.2022.
//


#import "React/RCTBridgeModule.h"
@interface RCT_EXTERN_MODULE(RNDocumentScanner,NSObject)

RCT_EXTERN_METHOD(startScan: (NSDictionary *)savePath success:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(detectRectangle: (NSString *)path success:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(dismiss)
@end

//
//  ActivityDetailRequest.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDetailRequest : NSObject
- (void)activityDetailRequestWithParameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure;
@end

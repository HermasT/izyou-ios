//
//  izyouDefine.h
//  izyou
//
//  Created by wudi on 2/10/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#ifndef izyouDefine_h
#define izyouDefine_h


#define izyScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define izyScreenHeight [[UIScreen mainScreen] bounds].size.height
#define izyURLHost      @"http://zhiyijia.cn"
#define izyURLLogin     @"/api/login"
#define izyURLNotes     @"/api/notes/{0}/{1}"
#define izyURLNote      @"/api/note/{0}/problems"
#define izyURLProblem   @"/api/problems/{0}/{1}"
#define izyURLCourse    @"/api/courses/{0}"
#define izyURLRegister  @"/api/course/register/{0}/{1}"
#define izyURLFeedBack  @"/api/feedback"
#define izyURLUpdate    @"/api/update"
#define izyURLBanners   @"/api/banners"
#define stringAppend(a,b) [NSString stringWithFormat:@"%@,%@",a,b];


#endif /* izyouDefine_h */

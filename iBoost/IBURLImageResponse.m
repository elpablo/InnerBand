//
// Copyright 2009-2010 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "IBURLImageResponse.h"

#import "IBURLRequest.h"
#import "IBURLCache.h"
#import "Macros.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation IBURLImageResponse

@synthesize image = _image;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  RELEASE_AND_NIL(_image);

  [super dealloc];
}


//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark IBURLResponse


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSError*)request:(IBURLRequest*)request processResponse:(NSHTTPURLResponse*)response
            data:(id)data {
  // This response is designed for NSData and UIImage objects, so if we get anything else it's
  // probably a mistake.

  if ([data isKindOfClass:[UIImage class]]) {
    _image = [data retain];

  } else if ([data isKindOfClass:[NSData class]]) {
    // TODO(jverkoey Feb 10, 2010): This logic doesn't entirely make sense. Why don't we just store
    // the data in the cache if there was a cache miss, and then just retain the image data we
    // downloaded? This needs to be tested in production.
    UIImage* image = [[IBURLCache sharedCache] imageForURL:request.URL fromDisk:NO];

    if (nil == image) {
      image = [UIImage imageWithData:data];
    }

    if (nil != image) {
      if (!request.respondedFromCache) {
// XXXjoe Working on option to scale down really large images to a smaller size to save memory      
//        if (image.size.width * image.size.height > (300*300)) {
//          image = [image transformWidth:300 height:(image.size.height/image.size.width)*300.0
//                         rotate:NO];
//          NSData* data = UIImagePNGRepresentation(image);
//          [[IBURLCache sharedCache] storeData:data forURL:request.URL];
//        }
        [[IBURLCache sharedCache] storeImage:image forURL:request.URL];
      }

      _image = [image retain];

    } else {
      return [NSError errorWithDomain:@"" code:0
                      userInfo:nil];
    }
  }

  return nil;
}


@end


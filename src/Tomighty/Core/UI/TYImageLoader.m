//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYImageLoader.h"

@implementation TYImageLoader

int const ICON_SIZE = 16;

- (NSImage *)iconNamed:(NSString *)name
{
    return [self TIFFImageNamed:name size:ICON_SIZE];
}

- (NSImage *)TIFFImageNamed:(NSString *)name size:(int)widthAndHeight
{
    NSString *fileName = [NSString stringWithFormat:@"%@.tiff", name];
    NSImage *image = [NSImage imageNamed:fileName];
    
    NSSize size;
    size.width = widthAndHeight;
    size.height = widthAndHeight;
    
    [image setSize:size];
    
    return image;
}

@end

//
//  UIImage+vImage.m
//  动画学习
//
//  Created by cheng on 14-8-19.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "UIImage+vImage.h"
#import <Accelerate/Accelerate.h>

static int16_t gaussianblur_kernel[25] = {
    1, 4, 6, 4, 1,
    4, 16, 24, 16, 4,
    6, 24, 36, 24, 6,
    4, 16, 24, 16, 4,
    1, 4, 6, 4, 1
};


static int16_t gaussianblur_kernel1[25] = {
    1, 2, 4, 2, 1,
    2, 4, 8, 4, 2,
    4, 8, 16, 8, 4,
    2, 4, 8, 4, 2,
    1, 2, 4, 2, 1
};


@implementation UIImage (vImage)

- (UIImage *)gaussianBlur
{
    
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width*4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space,kCGBitmapByteOrderDefault| kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext) {
        return nil;
    }
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data) {
        CGContextRelease(bmContext);
        return nil;
    }
    const size_t n = sizeof(UInt8)*width*height*4;
    void* outt = malloc(n);
    vImage_Buffer src = {data,height,width,bytesPerRow};
    vImage_Buffer des = {outt,height,width,bytesPerRow};
    
    vImageConvolve_ARGB8888(&src, &des, NULL, 00, 0, gaussianblur_kernel1, 5, 5, 256, NULL, kvImageCopyInPlace);
    memcpy(data, outt, n);
    free(outt);
    
    CGImageRef blurredImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* blurred = [UIImage imageWithCGImage:blurredImageRef];
    CGImageRelease(blurredImageRef);
    CGContextRelease(bmContext);
    return blurred;
}

- (UIImage *)blurryImagewithLevel:(CGFloat)blur
{
    
    if (blur<0.1f) {
        blur = 0.1f;
    }else if(blur>2.0f){
        blur = 2.0f;
    }
    int boxSize = (int)(blur*100);
    boxSize -= (boxSize%2)+1;
    CGImageRef img = self.CGImage;
    //图像缓存，输入和输出缓存
    vImage_Buffer inBuffer,outBuffer;
    //像素缓存
    void *pixelBuffer;
    //数据提供者
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img)*CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, CGImageGetBitmapInfo(self.CGImage));
    
    CGImageRef imageref = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageref];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageref);
    
    return  returnImage;
}

- (UIImage*)equalization
{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;
    
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    
    vImageEqualization_ARGB8888(&src, &dest, kvImageNoFlags);
    
    CGImageRef destImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* destImage = [UIImage imageWithCGImage:destImageRef];
    
    CGImageRelease(destImageRef);
    CGContextRelease(bmContext);
    
    return destImage;
}

@end

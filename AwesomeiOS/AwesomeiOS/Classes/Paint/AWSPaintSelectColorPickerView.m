//
//  AWSPaintSelectColorPickerViewDelegate.m
//  AwesomeiOS
//
//  Created by txooo on 2018/9/30.
//  Copyright © 2018年 领琾. All rights reserved.
//

#import "AWSPaintSelectColorPickerView.h"

#define MY_WIDTH    self.bounds.size.width
#define MY_HEIGHT   self.bounds.size.height
#define MY_CENTER   CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)

@interface AWSPaintSelectColorPickerView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *centerImageView;

@end

@implementation AWSPaintSelectColorPickerView
{
    UIButton *closeBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        
        closeBtn = ({
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:@"x" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:40];
            [button addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
        [self addSubview:closeBtn];
    }
    return self;
    return self;
}

- (void)closeSelf {
    self.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    closeBtn.frame = CGRectMake(MY_WIDTH - 50, 0, 50, 50);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIImage *centerImage = [UIImage imageNamed:@"colorPalette"];
    [centerImage drawInRect:CGRectMake(20, (MY_HEIGHT - (MY_WIDTH - 40)/2), MY_WIDTH - 40, MY_WIDTH - 40)];
    self.centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MY_CENTER.x - 15, MY_CENTER.y - 15, 30, 30)];
    self.centerImageView.image = [UIImage imageNamed:@"point.png"];
    [self addSubview:self.centerImageView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGFloat chassRadius = (MY_WIDTH -20)*0.5 ;
    CGFloat absDistanceX = fabs(currentPoint.x - MY_CENTER.x);
    CGFloat absDistanceY = fabs(currentPoint.y - MY_CENTER.y);
    CGFloat currentToPointRadius = sqrtf(absDistanceX *absDistanceX + absDistanceY *absDistanceY);
    
    if (currentToPointRadius < chassRadius) {
        self.centerImageView.center = currentPoint;
        UIColor *color = [self getPixelColorAtLocation:currentPoint];
        if (self.delegate && [self.delegate respondsToSelector:@selector(getCurrentColor:)]) {
            [self.delegate getCurrentColor:color];
        }
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGFloat chassisRadius = (MY_WIDTH - 20)*0.5 - MY_WIDTH/20;
    CGFloat absDistanceX = (currentPoint.x - MY_CENTER.x);
    CGFloat absDistanceY = (currentPoint.y - MY_CENTER.y);
    CGFloat currentTopointRadius = sqrtf(absDistanceX * absDistanceX + absDistanceY *absDistanceY);
    
    if (currentTopointRadius <chassisRadius) {
        //取色
        self.centerImageView.center = currentPoint;
        UIColor *color = [self getPixelColorAtLocation:currentPoint];
        if(self.delegate && [self.delegate respondsToSelector:@selector(getCurrentColor:)]){
            
            [self.delegate getCurrentColor:color];
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //这句话可以去掉，去掉的话就必须点击右上角叉叉关闭
    self.hidden = YES;
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (UIColor*) getPixelColorAtLocation:(CGPoint)point
{
    UIColor* color = nil;
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRef inImage = viewImage.CGImage;
    
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) {
        return nil;
    }
    
    size_t w = self.bounds.size.width;
    size_t h = self.bounds.size.height;
    
    CGRect rect = {{0,0},{w,h}};
    CGContextDrawImage(cgctx, rect, inImage);
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        int offset = 4*((w*round(point.y))+round(point.x));
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
    }
    CGContextRelease(cgctx);
    if (data) { free(data); }
    return color;
}

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void * bitmapData;
    int bitmapByteCount;
    int bitmapBytesPerRow;
    
    size_t pixelsWide = self.bounds.size.width;
    size_t pixelsHigh = self.bounds.size.height;
    
    bitmapBytesPerRow   = (int)(pixelsWide * 4);
    bitmapByteCount     = (int)(bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL){
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL){
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    context = CGBitmapContextCreate (bitmapData,pixelsWide,pixelsHigh,8, bitmapBytesPerRow,
                                     colorSpace,kCGImageAlphaPremultipliedFirst);
    if (context == NULL){
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    CGColorSpaceRelease( colorSpace );
    return context;
}

@end

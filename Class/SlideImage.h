//
//  SlideImage
//  Copyright © 2016年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EScrollerViewTouchImage) (NSUInteger tag,UIImageView *image,NSMutableArray *picArry); //图片点击block
typedef void(^ScrollImage)(); // 图片滚动事件

@interface SlideImage : UIView<UIScrollViewDelegate>
@property (strong,nonatomic) NSMutableArray *picArry;
@property (nonatomic, copy)  EScrollerViewTouchImage touchImage;
@property (nonatomic, copy)  ScrollImage scrollImage;
@property (strong,nonatomic) UIPageControl *pageControl;

-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr;
@end

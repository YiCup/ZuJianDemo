//
//  SlideImage
//  Copyright © 2016年 lz. All rights reserved.
//

#import "SlideImage.h"

@interface SlideImage ()
{
    NSArray *titleArray;
    int currentPageIndex;
}

@property (nonatomic) CGRect viewSize;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) UILabel *noteTitle;
@property (nonatomic,strong) UIView  *noteView;

@end
@implementation SlideImage


#pragma mark -initProperty
//初始化轮番组件
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *) titArr{

    if ((self=[super initWithFrame:rect])) {
        self.backgroundColor= [UIColor clearColor];
        self.userInteractionEnabled=YES;
        self.viewSize=rect;
        titleArray=titArr ;
        self.imageArray=[NSArray arrayWithArray:imgArr];
        
        //给每一页添加图片
        NSUInteger pageCount=[self.imageArray count];
        for (int i=0; i<pageCount&&pageCount!=0; i++) {
            NSString *imgURL;
            if (self.imageArray.count != 0) {
                imgURL = [self.imageArray objectAtIndex:i];
            }
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.contentMode = UIViewContentModeScaleToFill;
            imgView.clipsToBounds=YES;
            imgView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
            
            if ([imgURL hasPrefix:@"https://"] || [imgURL hasPrefix:@"http://"]) {
                imgView.image = [UIImage imageNamed:@""];
                
            }else{
                UIImage *imge;
                if (self.imageArray.count != 0) {
                    imge = [UIImage imageNamed:[self.imageArray objectAtIndex:i]];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imgView setImage:imge];
                });
            }
            
            [imgView setFrame:CGRectMake(self.viewSize.size.width*i, 0,self.viewSize.size.width, self.viewSize.size.height)];
            imgView.tag=i;
            UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)] ;
            [Tap setNumberOfTapsRequired:1];
            [Tap setNumberOfTouchesRequired:1];
            imgView.userInteractionEnabled=YES;
            [imgView addGestureRecognizer:Tap];
            [self.scrollView addSubview:imgView];
            [self.picArry addObject:imgView];
        }
        //[self.scrollView setContentOffset:CGPointMake(self.viewSize.size.width, 0)];
        [self addSubview:self.scrollView];
        //添加说明文字视图
        [self noteView];
    }
    return self;
}


//初始化scrollview
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.viewSize.size.width, self.viewSize.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(self.viewSize.size.width * self.imageArray.count, self.viewSize.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

//初始化文本视图
- (UIView *)noteView {
    if (!_noteView) {
        _noteView=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-33,self.bounds.size.width,33)];
        [_noteView setBackgroundColor:[UIColor clearColor]];
        [_noteView addSubview:self.pageControl];
        [_noteView addSubview:self.noteTitle];
        [self addSubview:_noteView];
    }
    return _noteView;
}

//初始化翻页控件
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0,6,[UIScreen mainScreen].bounds.size.width, 20.0f)];
        _pageControl.currentPage=0;
        _pageControl.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [_pageControl setUserInteractionEnabled:NO];
        _pageControl.numberOfPages=(self.imageArray.count);
    }
    return _pageControl;
}

//初始化文本title
- (UILabel *)noteTitle {
//    if (!_noteTitle) {
//        float pageControlWidth=(self.imageArray.count-2)*10.0f+40.f;
//        _noteTitle=[[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.frame.size.width-pageControlWidth-15, 20)];
//        if (titleArray.count != 0) {
//            [_noteTitle setText:[titleArray objectAtIndex:0]];
//        }
//        [_noteTitle setBackgroundColor:[UIColor clearColor]];
//        _noteTitle.textColor=[UIColor whiteColor];
//        [_noteTitle setFont:[UIFont systemFontOfSize:13]];
//    }
    return _noteTitle;
}

//轮番图片数组
- (NSMutableArray *)picArry {
    if (!_picArry) {
        _picArry = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _picArry;
}


#pragma mark -scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    self.pageControl.currentPage = page;
    
    if (self.scrollImage) {
        self.scrollImage();
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView {

}

//图片点击事件
- (void)imagePressed:(UITapGestureRecognizer *)sender {
    if (self.touchImage) {
        self.touchImage(sender.view.tag,(UIImageView*)sender.view,self.picArry);
    }
}


@end

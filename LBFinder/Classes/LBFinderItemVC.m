//
//  LBFinderItemVC.m
//  LBFinder
//
//  Created by 李兵 on 2018/1/12.
//

#import "LBFinderItemVC.h"
#import "LBFinderItem.h"
@interface LBFinderItemVC ()
@property (nonatomic, strong)LBFinderItem *item;
@property (nonatomic, copy)NSString *info;
@property (nonatomic, strong)UITextView *infoView;
@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation LBFinderItemVC

#pragma mark -- Getter
- (NSString *)info {
    if (!_info) {
        NSMutableString *str = [NSMutableString string];
        [str appendFormat:@"path:\n\t%@\n\n", self.item.path];
        [str appendFormat:@"name:\n\t%@\n\n", self.item.name];
        [str appendFormat:@"size:\n\t%@\n\n", self.item.sizeString];
        _info = str.copy;
    }
    return _info;
}
- (UITextView *)infoView {
    if (!_infoView) {
        CGFloat w = self.view.bounds.size.width - 20;
        CGFloat h = [self.info boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} context:nil].size.height;
        h+=20;
        _infoView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), w, h)];
        _infoView.font = [UIFont systemFontOfSize:12.0f];
        _infoView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [self.view addSubview:_infoView];
    }
    return _infoView;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infoView.frame), self.view.bounds.size.width, CGRectGetMaxY(self.view.frame)-CGRectGetMaxY(self.infoView.frame))];
        _textView.font = [UIFont systemFontOfSize:12.0f];
        _textView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [self.view addSubview:_textView];
    }
    return _textView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infoView.frame), self.view.bounds.size.width, CGRectGetMaxY(self.view.frame)-CGRectGetMaxY(self.infoView.frame))];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark -- Life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSet];
}

#pragma mark -- Init
- (void)initSet {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.item.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
    self.infoView.text = self.info;
    [self readFile];
}

#pragma mark -- Utilities
- (void)readFile {
    NSError *error;
    switch (self.item.type) {
        case LBFinderItemTypeFileText: {
            self.textView.text = [NSString stringWithContentsOfFile:self.item.path encoding:NSUTF8StringEncoding error:&error];
            break;
        }
        case LBFinderItemTypeFileImage: {
            self.imageView.image = [UIImage imageWithContentsOfFile:self.item.path];
            if (self.imageView.image.size.width < self.imageView.bounds.size.width &&
                self.imageView.image.size.height < self.imageView.bounds.size.height) {
                CGPoint center = self.imageView.center;
                CGRect rec = self.imageView.frame;
                rec.size = self.imageView.image.size;
                self.imageView.frame = rec;
                self.imageView.center = center;
            }
            break;
        }
        default: {
            self.textView.text = [NSString stringWithContentsOfFile:self.item.path encoding:NSUTF8StringEncoding error:&error];
            break;
        }
    }
    if (error) {
        NSLog(@"File cann't read, %@", error);
    }
}

#pragma mark -- Action
- (void)shareAction:(UIBarButtonItem *)sender {
    NSURL *url = [NSURL fileURLWithPath:self.item.path];
    if (url) {
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
        [self presentViewController:vc animated:YES completion:nil];
    }else {
        NSLog(@"file is wrong, %@", url);
    }
}

#pragma mark - Public
+ (instancetype)instanceWithItem:(LBFinderItem *)item {
    LBFinderItemVC *vc = [LBFinderItemVC new];
    vc.item = item;
    return vc;
}
@end

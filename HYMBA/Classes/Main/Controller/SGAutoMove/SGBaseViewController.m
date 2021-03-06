//
//  SGBaseViewController.m
//  huxijia
//
//  Created by xue on 16/1/20.
//  Copyright © 2016年 xue. All rights reserved.
//

#import "SGBaseViewController.h"
#import "UIView+Uitls.h"

@interface SGBaseViewController (){

        CGFloat _totalYOffset;
    

}

@end

@implementation SGBaseViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        _totalYOffset = 0;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    CGFloat keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;;
    [self.view.layer removeAllAnimations];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponderView = [keyWindow performSelector:@selector(findFirstResponder)];
    
    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:firstResponderView.frame fromView:firstResponderView.superview];
    
    CGFloat bottom = rect.origin.y + rect.size.height;
    CGFloat keyboardY = self.view.window.size.height - keyboardHeight;
    if (bottom > keyboardY) {
        _totalYOffset += bottom - (self.view.window.size.height - keyboardHeight);
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                              delay:0
                            options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
                         animations:^{
                             self.view.y -= _totalYOffset;
                         }
                         completion:nil];
    }
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    
    
    [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
                     animations:^{
                         self.view.y = 0;
                     }
                     completion:nil];
    _totalYOffset = 0;
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    
}

- (void)keyboardDidShow:(NSNotification *)noti
{
}

- (void)keyboardDidHide:(NSNotification *)noti
{
    [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
                     animations:^{
                         self.view.y += _totalYOffset;
                     }
                     completion:nil];
    _totalYOffset = 0;
    
    
}

- (void)keyboardDidChangeFrame:(NSNotification *)noti
{
}


- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

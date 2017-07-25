//
//  BaseNavigationController.m
//  Pods
//
//  Created by 金泉斌 on 2017/7/6.
//
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@property (strong, nonatomic) UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.hidden = YES;
}

- (void)setIsInteractivePopGestureRecognizerEnable:(BOOL)isInteractivePopGestureRecognizerEnable{
    NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
    id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    if (isInteractivePopGestureRecognizerEnable) {
        _edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:internalTarget action:internalAction];
        _edgePanGestureRecognizer.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:_edgePanGestureRecognizer];
    }else{
        [_edgePanGestureRecognizer removeTarget:internalTarget action:internalAction];
        [self.view removeGestureRecognizer:_edgePanGestureRecognizer];
    }
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

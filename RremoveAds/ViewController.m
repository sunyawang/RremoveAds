//
//  ViewController.m
//  RremoveAds
//
//  Created by 孙亚旺 on 15/6/30.
//  Copyright (c) 2015年 孙亚旺. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIWebView *m_webV;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60)];
    [self.view addSubview:m_webV];
    [m_webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.youku.com"]]];

    UIButton *removeAdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    removeAdBtn.frame = CGRectMake(0, m_webV.frame.size.height, m_webV.frame.size.width, 60);
    [removeAdBtn setTitle:@"Remove AD" forState:UIControlStateNormal];
    [removeAdBtn addTarget:self action:@selector(removeAdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeAdBtn];
}

- (void)removeAdBtnClick
{
    [self removeDomById:@"sideBar"];
    [self removeDomById:@"addDesktop_iphone"];
}

/**
 *  根据ID移除对应节点
 *
 *  @param divID 节点ID
 */
- (void)removeDomById:(NSString *)divID
{
    //创建一段JS脚本
    NSString *jsString = [NSString stringWithFormat:
                          @"var script = document.createElement('script');"
                          "script.type = 'text/javascript';"
                          "script.text = \"function removeDom() { "
                          "var div=document.getElementById('%@');" //获取节点
                          "div.parentNode.removeChild(div);"       //删除节点
                          "}\";"
                          "document.getElementsByTagName('head')[0].appendChild(script);",divID];
    //插入JS
    [m_webV stringByEvaluatingJavaScriptFromString:jsString];
    
    //调用刚才JS里的函数
    [m_webV stringByEvaluatingJavaScriptFromString:@"removeDom();"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

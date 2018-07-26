//
//  ViewController.m
//  StackViewTest
//
//  Created by Goko on 08/08/2017.
//  Copyright © 2017 Goko. All rights reserved.
//

#import "ViewController.h"

#define randomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]

@interface ViewController ()
@property(nonatomic,weak)UIStackView * stackView;
@property(nonatomic,copy)NSArray * axisArray;
@property(nonatomic,copy)NSArray * distributionArray;
@property(nonatomic,copy)NSArray * alignmentArray;
@end

@implementation ViewController

-(NSArray *)axisArray{
    if (!_axisArray) {
        _axisArray = @[@"UILayoutConstraintAxisHorizontal",
                       @"UILayoutConstraintAxisVertical"];
    }
    return _axisArray;
}
-(NSArray *)distributionArray{
    if (!_distributionArray) {
        _distributionArray = @[@"UIStackViewDistributionFill",
                               @"UIStackViewDistributionFillEqually",
                               @"UIStackViewDistributionFillProportionally",
                               @"UIStackViewDistributionEqualSpacing",
                               @"UIStackViewDistributionEqualCentering"];
    }
    return _distributionArray;
}
-(NSArray *)alignmentArray{
    if (!_alignmentArray) {
        _alignmentArray = @[@"UIStackViewAlignmentFill",
                            @"UIStackViewAlignmentLeading",
                            @"UIStackViewAlignmentTop",
                            @"UIStackViewAlignmentFirstBaseline",
                            @"UIStackViewAlignmentCenter",
                            @"UIStackViewAlignmentTrailing",
                            @"UIStackViewAlignmentBottom",
                            @"UIStackViewAlignmentLastBaseline"];
    }
    return _alignmentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIStackView * stackView = [self createStackView];
    stackView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 200);
    [self.view addSubview:stackView];
    self.stackView = stackView;
    
    //cateogry  addImage/addLabel/addView
    
    UIStackView * stackViewLeft = [self createStackView];
    [stackView addArrangedSubview:stackViewLeft];
    [stackViewLeft addArrangedSubview:[self createImageView]];
    
    
    UIStackView * stackViewRight = [self createStackView];
    stackViewRight.axis = UILayoutConstraintAxisVertical;
    [stackView addArrangedSubview:stackViewRight];
    
    UIStackView * topStack = [self createStackView];
    UIStackView * bottomStack = [self createStackView];
    [stackViewRight addArrangedSubview:topStack];
    [stackViewRight addArrangedSubview:bottomStack];
    
    [topStack addArrangedSubview:[self createLabel:@"hello"]];
    [bottomStack addArrangedSubview:[self createImageView]];
    [bottomStack addArrangedSubview:[self createLabel:@"[[UIStackView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];"]];
    
    [self creatControlPanel];
}
-(UIImageView *)createImageView{
    UIImageView * imageView = [UIImageView new];
    imageView.backgroundColor = randomColor;
    imageView.image = [UIImage imageNamed:@"abc"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}
-(UIStackView *)createStackView{
    UIStackView * stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.backgroundColor = randomColor;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 5;
    return stackView;
}
-(void)creatControlPanel{
    UILabel * axisLabel = [self createLabel:@"AxisLabel"];
    axisLabel.tag = 100;
    axisLabel.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-300, self.view.bounds.size.width, 100);
    [self.view addSubview:axisLabel];
    
    UILabel * distributionLabel = [self createLabel:@"DistributionLabel"];
    distributionLabel.tag = 101;
    distributionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-200, self.view.bounds.size.width, 100);
    [self.view addSubview:distributionLabel];
    
    UILabel * alignmentLabel = [self createLabel:@"AlignmentLabel"];
    alignmentLabel.tag = 102;
    alignmentLabel.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)-100, self.view.bounds.size.width, 100);
    [self.view addSubview:alignmentLabel];

}
-(UILabel *)createLabel:(NSString *)text{
    UILabel * tempLabel = [UILabel new];
    tempLabel.userInteractionEnabled = YES;
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.numberOfLines = 0;
    tempLabel.backgroundColor = randomColor;
    tempLabel.text = text;
    [tempLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)]];
    return tempLabel;
}
-(void)labelTapped:(UITapGestureRecognizer *)tapGes{
    UILabel * label = (UILabel *)tapGes.view;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:label.text message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    switch (tapGes.view.tag) {
        case 100:
        {
            [self.axisArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [alert addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.stackView.axis = idx;
                    label.text = obj;
                }]];
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        case 101:
        {
            [self.distributionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [alert addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.stackView.distribution = idx;
                    label.text = obj;
                }]];
            }];
            [self presentViewController:alert animated:YES completion:nil];

        }
            
            break;
        case 102:
        {
            [self.alignmentArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [alert addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.stackView.alignment = idx;
                    label.text = obj;
                }]];
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }
            
            break;
        default:
            break;
    }
    NSLog(@"%@",label.text);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

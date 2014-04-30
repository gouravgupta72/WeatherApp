
#import <Foundation/Foundation.h>

@protocol RequestDelegate;
@interface Request : NSObject
{
    NSURLConnection *conn;
    NSMutableData *webData;
    id<RequestDelegate>delegate;
    int RequestId;
    NSString *a,*b;
    NSMutableArray *DataArray;
}
@property(nonatomic,retain)id<RequestDelegate>delegate;
-(void)request:(NSString *)parameter ;
@end

@protocol RequestDelegate <NSObject>
-(void)getResult:(id)jsonData;
@optional
-(void)getError:(id)error;
@end
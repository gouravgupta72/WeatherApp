//
//  Request.m
//  TestWebServices
//


#import "Request.h"

#define server_Domain @"http://api.openweathermap.org/data/2.5/forecast/daily?"

@implementation Request
@synthesize delegate;

-(void) request :(NSString *)parameter
{
     NSString *queryForServer=[NSString stringWithFormat:@"%@q=%@%@",server_Domain,parameter,@"&mode=json&units=metric&cnt=14"];
    
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:queryForServer]
                                                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                               timeoutInterval:30];
    [urlRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //set post data of request
    [urlRequest setHTTPBody:[parameter dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPMethod:@"POST"];
    conn = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
    
    
    if(conn)
    {
        
        webData = [[NSMutableData alloc] init];
    }
    else
    {
        NSLog(@"theConnection is NULL");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil message:@"Connection Time out !!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }

}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *)error
{
    if (error!=nil) {
        if ([self.delegate conformsToProtocol:@protocol(RequestDelegate)])
        {
            if ([self.delegate respondsToSelector:@selector(getError:)])
            {
                [self.delegate getError:error];
            }
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil message:@"Connection Time out !!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    conn=nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *parseError = nil;
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:webData
                                                             options:kNilOptions
                                                               error:&parseError];
    
    conn=nil;
    
    if (jsonDict!=nil)
    {
        if ([self.delegate conformsToProtocol:@protocol(RequestDelegate)])
        {
            if ([self.delegate respondsToSelector:@selector(getResult:)])
            {
                [self.delegate getResult:jsonDict];
            }
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil message:@"Unable to process" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)dealloc
{
    self.delegate=nil;
}


@end

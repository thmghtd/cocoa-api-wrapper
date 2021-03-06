/*
 * Copyright 2009 Ullrich Schäfer, Gernot Poetsch for SoundCloud Ltd.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 *
 * For more information and documentation refer to
 * http://soundcloud.com/api
 * 
 */

#import "NSMutableURLRequest+SoundCloudAPI.h"

@implementation NSMutableURLRequest (SoundCloudAPI)
- (void)setParameterDictionary:(NSDictionary *)parameters;
{
	if (!parameters) return;
	NSMutableArray *parameterArray = [NSMutableArray array];
	for (NSString *key in parameters) {
		id val = [parameters objectForKey:key];
		if ([val isKindOfClass:[NSArray class]]) {
			for (NSString *string in val) {
				OARequestParameter *param = [[OARequestParameter alloc]initWithName:key value:string];
				[parameterArray addObject:param];
				[param release];
			}
		} else {
			OARequestParameter *param = [[OARequestParameter alloc]initWithName:key value:val];
			[parameterArray addObject:param];
			[param release];
		}
	}
	
	[self setParameters:parameterArray];
}

@end

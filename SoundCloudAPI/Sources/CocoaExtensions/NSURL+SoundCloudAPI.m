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

#import "NSURL+SoundCloudAPI.h"

#import "NSString+URLEncoding.h"

@implementation NSURL (SoundCloudAPI)

- (NSURL *)urlByAddingParameters:(NSDictionary *)parameterDictionary {
	if (!parameterDictionary
		|| [parameterDictionary count] == 0) {
		return self;
	}
	
	NSString *absoluteString = [self absoluteString];

	NSMutableArray *parameterPairs = [NSMutableArray array];
	for (NSString *key in [parameterDictionary allKeys]) {
		NSString *pair = [NSString stringWithFormat:@"%@=%@", key, [[parameterDictionary objectForKey:key] URLEncodedString]];
		[parameterPairs addObject:pair];
	}
	NSString *queryString = [parameterPairs componentsJoinedByString:@"&"];
	
	NSRange parameterRange = [absoluteString rangeOfString:@"?"];
	if (parameterRange.location == NSNotFound) {
		absoluteString = [NSString stringWithFormat:@"%@?%@", absoluteString, queryString];
	} else {
		absoluteString = [NSString stringWithFormat:@"%@&%@", absoluteString, queryString];
	}

	return [NSURL URLWithString:absoluteString];
}

- (NSString *)valueForQueryParameterKey:(NSString *)aKey;
{
	NSString *queryString = [self query];
	NSArray *keyValuePairs = [queryString componentsSeparatedByString:@"&"];
	for (NSString *keyValueString in keyValuePairs) {
		NSArray *keyValuePair = [keyValueString componentsSeparatedByString:@"="];
		if (keyValuePair.count != 2)
			continue;
		NSString *key = [keyValuePair objectAtIndex:0];
		NSString *value = [keyValuePair objectAtIndex:1];
		if ([aKey isEqualToString:key])
			return value;
	}
	return nil;
}


@end

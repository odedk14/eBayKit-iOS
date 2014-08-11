eBayKit
===========

A simple iOS wrapper inspired by <a href='https://github.com/shyambhat/InstagramKit'>InstagramKit</a> for integrating your app with eBay platform.

This framework is built atop AFNetworking’s blocks-based architecture.
It’s neat, fast and works like a charm providing an easy interface to interacting with eBay’s model objects.

The only method which is implemented is the eBay method "findItemsAdvanced", which allows the user to get all product information. If I forgot something, just let me know and I will add it / fix it.

###Installation

First, you will need to create a developer account on eBay (https://developer.ebay.com).
Once you create your accout, grab the AppId eBay generates for you. You will need it.

Just copy the folder 'EbayKit' to your project.
In EbayKit.plist, paste your AppId instead of <Client id here>.

## Demo

Download and run the Demo Project to understand how the engine is intended to be used.

##Usage

###Filter

You can add filters to your search. The types of attributes you can filter in located here: 
http://developer.ebay.com/Devzone/finding/CallRef/types/ItemFilterType.html

The filter object is of NSDictionary type.
The key is a NSString represents the filterType value (from the link above).
The Value is a NSArray of NSStrings, represents all the possible values for filtering (from the link above).

Example:<br>
NSDictionary* filter = @{@"ListingType": @[@"Auction", @"FixedPrice"]};<br>
This filters the search only for products which are auctions and fixed priced.

###Output Selector

The types that you can use in the output selector can be found here:
http://developer.ebay.com/Devzone/finding/CallRef/types/OutputSelectorType.html

The output selector defines additional attributes to retrieve in your search.
The output selector object is of NSArray type, which contains NSStrings.

Example:<br>
NSArray* outputSelector = @[@"SellerInfo"];
This output selector indicates that the seller info will be retrieved with the product.

##What's next?

Working on some more eBay methods to implement.
Working on affiliations.


That's all for now!
Enjoy.

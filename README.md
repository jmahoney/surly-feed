# The Surly Bikes Blog, in a feed

This is a quick and dirty scrape of the [Surly Bikes Blog](https://surlybikes.com/blog) converted to the [JSON Feed](https://jsonfeed.org) format.

You can subscribe to the feed at http://surly-feed.cheerschopper.com

### Why not the full content of the blog

1) Scaping the first page of the blog was easy. Following all the links and getting the content is actual fucking work.
2) I haven't asked Surly's permission to do this so I'm not really comfortable scraping their whole blog.

### Why JSON Feed?
It was the easiest to implement. Ruby and JSON are extremely compatible.

[Validate the feed](https://validator.jsonfeed.org/?url=http%3A%2F%2Fsurly-feed.cheerschopper.com)

## Contributing

If you find a bug, want to add a different feed format, want to add more features, or generally pretty up the code you can clone the project, make your changes, and send a pull request.
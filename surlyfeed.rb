require "nokogiri"
require "httparty"
require "sinatra"
require "date"

items = []
last_fetched = Date.today - 7

get "/" do
  if  items.empty? || last_fetched < DateTime.now - 0.5
    items = fetch_and_parse
    last_fetched = DateTime.now
  end

  feed = {
    version: "https://jsonfeed.org/version/1",
    title: "Surly Bikes Feed",
    home_page_url: "https://surlybikes.com/blog",
    feed_url: "http://surly-feed.cheerschopper.com",
    items: items
  }

  content_type "application/json"
  feed.to_json
end

def fetch_and_parse
  response = HTTParty.get("https://surlybikes.com/blog")

  if response.success?
    doc = Nokogiri.HTML(response.body)

    feed = []

    rows = doc.css("li[class='entry highlight']")

    rows.each do |row|
      header = row.css("h2[class='title']").first
      permalink="https://surlybikes.com#{header.children.first['href']}"
      title = header.text
      date = row.css("span[class='date']").first
      author = row.css("span[class='author']").first
      hero_image = row.css("img").first
      html = "#{author.to_html} #{date.to_html} <br/ ><br /> #{hero_image.to_html}"
      feed << {id: permalink, url: permalink, content_html: html, title: title, date_published: DateTime.parse(date.text).to_s}
    end

    return feed
  end


end





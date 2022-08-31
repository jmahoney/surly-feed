require "oga"
require "date"
require "net/http"
require "json"

def feed(event:, context:)
  begin
    feed = fetch_and_parse()

    {
      statusCode: 200,
      headers: { "content-type": "application/json; charset=utf-8" },
      body: feed.to_json
    }
  rescue
    puts e.message
    puts e.backtrace.inspect
    { statusCode: 400, body: JSON.generate("Something went wrong") }
  end
end

def fetch_and_parse
  uri = URI("https://surlybikes.com/blog")
  response = Net::HTTP.get_response(uri)

  if response.code == "200"

    doc = Oga.parse_html(response.body.force_encoding("UTF-8").encode("UTF-8"))

    items = []

    rows = doc.css("li[class='entry highlight']")
    rows += doc.css("li[class='entry']")

    rows.each do |row|
      header = row.css("h2[class='title']").first
      permalink="https://surlybikes.com#{header.children.first['href']}"
      title = header.text
      date = row.css("span[class='date']").first
      author = row.css("span[class='author']").first
      hero_image = row.css("img").first
      html = "#{author} #{date} <br/ ><br /> #{hero_image}"
      items << {id: permalink, url: permalink, content_html: html, title: title, date_published: DateTime.parse(date.text).to_s}
    end


    return {
      version: "https://jsonfeed.org/version/1",
      title: "Surly Bikes Feed",
      home_page_url: "https://surlybikes.com/blog",
      feed_url: "http://surly-feed.cheerschopper.com",
      items: items
    }

  else
    return {}
  end
end







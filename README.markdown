#Creating a Scraper object

Working with patterns and objects to create a scraper class that can handle any site.

The Scraper object is an abstraction of the two original scrapers that I built to get jobs from Ruby Inside and Ruby Now. The original version is here: ruby_inside_scraper.rb and ruby_now_scraper.rb

The current working version of the scraper is in app.rb and scraper.rb

## Anatomy of a scraper

1. Visit an index page
2. Grab all of the URLs you want
3. Visit each of the URLs
4. Select the information you want
5. Write to database
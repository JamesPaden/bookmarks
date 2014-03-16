class Bookmark < ActiveRecord::Base
	has_many :tags

	def self.import_chrome
		html = open("tmp/bookmarks_3_16_14.html").read

		#fixing html that nokogiri can't handle well
		html = html.gsub("<p>", "")
		html = html.gsub("</A>", "</A></DT>")
		doc = Nokogiri::HTML(html)

		chrome_recursive(doc.css("body > dl > dt"), 0)
	end

	def self.chrome_recursive(dts, parent_id)
		dts.each do |dt|
			if dt.css(" > h3").length > 0
				#category
				puts ("   " * parent_id) + dt.css(" > h3").text.upcase
				chrome_recursive(dt.xpath("following-sibling::dl[1]/dt"), parent_id + 1)
			elsif dt.css(" > a").length > 0
				#bookmark
				puts ("   " * parent_id) + dt.css(" > a").text.gsub("\r", "").gsub("\n", "").strip
			end
		end
	end
end

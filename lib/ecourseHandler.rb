#!/usr/bin/env ruby
#encoding:utf-8

require 'net/http'
require 'date'

require 'rubygems'
require 'mechanize'
require 'nokogiri'

require 'pry'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

class EcourseHandler
  def initialize ()
    @id = nil
    @pass = nil
    @courseId = Hash.new
    @homeworkData = Struct.new(:id, :name, :done, :courseID, :date)
	@agent = Mechanize.new { |a|
	  a.follow_meta_refresh = true
	}
  end
  def login(id = nil, pass = nil)
    @id = id if id
    @pass = pass if pass
    raise "No ID and Password" unless @id
    @agent.get("http://ecourse.elearning.ccu.edu.tw/")
	@agent.page.form_with(:name => 'loginform') { |form|
	  form.id = @id
	  form.pass = @pass
	}.submit
    raise "Login Fail" if ! @agent.page.uri.path.match(%r!^/php/Courses_Admin/!)
    @session = @agent.cookies.select{|x| x.name == "PHPSESSID"}[0].value
    getCourseIdList()
    return true
  end
  def getCourse
    checkLogin()
    return @courseId.values
  end
  def getHomework
    checkLogin()
    homework = Hash.new
    @courseId.each { |k, v|
      @agent.get("http://ecourse.elearning.ccu.edu.tw/php/login_s.php?courseid=#{k}")
      @agent.get("http://ecourse.elearning.ccu.edu.tw/php/Testing_Assessment/show_allwork.php")
      homework[v]=[]
	  @agent.page.encoding = 'BIG5'
	  webPage = @agent.page.parser
      webPage.css("table table tr").drop(1).map { |x|
		next if x.css("td input[value=\"uploadwork\"]")[0]['disabled']
        workId = x.css("td input[name=\"work_id\"]")[0]['value']
        name = x.css("td")[1].text.encode("UTF-8")
		date = Date.parse(x.css("td")[3].text.chomp)
		@agent.page.forms.detect{|x| x['action'] == 'seemywork' && x['work_id'] == workId}.submit
		page = @agent.page.parser
		#binding.pry
		if page.css("body").empty?
		  done=false
		else
		  done=true
		end
        homework[v] << @homeworkData.new(workId, name, done, k, date)
		@agent.back
      }

    }
    return homework
  end
  def getId
    checkLogin()
    return @courseId.keys
  end
  def logout
	@agent.get("http://ecourse.elearning.ccu.edu.tw/php/logout.php")
  end
  private
  def checkLogin
	@agent.get("http://ecourse.elearning.ccu.edu.tw/php/Courses_Admin/take_course.php?PHPSESSID=#{@session}")
	if (@agent.page.parser.css("title").text.encode("UTF-8", "BIG5", :undef => :replace, :invalid => :replace) =~ /權限錯誤/)
	  login()
	end
  end
  def getCourseIdList
    checkLogin()
    #homework = Hash.new
    @agent.get("http://ecourse.elearning.ccu.edu.tw/php/Courses_Admin/take_course.php?PHPSESSID=#{@session}&frame=1")
    @agent.page.parser.css("table table td font a[href != \"#\"]").each { |x|
      @courseId [x["href"].split("=")[1]] = x.text.chomp if x.text.chomp != ""
    }
  end
  def getResp(uriOrStr, post=false, data=nil)
    case uriOrStr
    when String
      uri = URI.parse(uriOrStr)
    when URI
      uri = uriOrStr
    else
      raise ArgumentError "getResp argument must be string or uri"
    end
    http = Net::HTTP.new(uri.host, uri.port)
    if post
      req = Net::HTTP::Post.new(uri.path)
      if data.is_a? Hash
        req.set_form_data(data)
      else
        raise ArgumentError "getResp:data except Hash but is a #{data.class}"
      end
	  req['Cookie']=@session
	  resp = http.request(req)
    else
      resp = http.get(uri.request_uri, {'Cookie' => @session})
    end
    case resp
    when Net::HTTPSuccess
      return resp
    else
      raise "Http error"
    end
  end
end


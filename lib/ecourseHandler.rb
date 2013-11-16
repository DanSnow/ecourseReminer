#!/usr/bin/env ruby
#encoding:utf-8

require 'net/http'
require 'date'

require 'rubygems'
require 'mechanize'
require 'nokogiri'

require 'pry'

class EcourseHandler
  def initialize ()
    @id = nil
    @pass = nil
    @courseId = Hash.new
    @homeworkData = Struct.new(:id, :name, :done, :courseID, :date)
  end
  def login(id = nil, pass = nil)
    @id = id if id
    @pass = pass if pass
    raise "No ID and Password" if !@id
    postData = Net::HTTP.post_form(URI.parse('http://ecourse.elearning.ccu.edu.tw/php/index_login.php'), {'id' => @id, 'pass' => @pass, 'ver' => 'C'})
    raise "Login Fail" if postData.code != "302"
    @session = postData['set-cookie'].split(";")[0]
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
      getResp("http://ecourse.elearning.ccu.edu.tw/php/login_s.php?courseid=#{k}")
      resp = getResp("http://ecourse.elearning.ccu.edu.tw/php/Testing_Assessment/show_allwork.php")
      page = Nokogiri::HTML(resp.body.encode("UTF-8", "BIG5", :undef => :replace, :invalid => :replace))
      homework[v]=[]
      page.css("table table tr").drop(1).map { |x|
		#binding.pry
		next if x.css("td input[value=\"uploadwork\"]")[0]['disabled']
        workId = x.css("td input[name=\"work_id\"]")[0]['value']
        name = x.css("td")[1].text
		date = Date.parse(x.css("td")[3].text.chomp)
		resp = getResp("http://ecourse.elearning.ccu.edu.tw/php/Testing_Assessment/show_allwork.php", true, {'action' => 'seemywork', 'work_id' => workId})
		page = Nokogiri::HTML(resp.body.encode("UTF-8", "BIG5", :undef => :replace, :invalid => :replace))
		if page.css("body").empty?
		  done=false
		else
		  done=true
		end
        homework[v] << @homeworkData.new(workId, name, done, k, date)
      }
    }
    return homework
  end
  def getId
    checkLogin()
    return @courseId.keys
  end
  def logout
	getResp("http://ecourse.elearning.ccu.edu.tw/php/logout.php")
  end
  private
  def checkLogin
	resp = getResp("http://ecourse.elearning.ccu.edu.tw/php/Courses_Admin/take_course.php?PHPSESSID=#{@session}")
	page = Nokogiri::HTML(resp.body.encode("UTF-8", "BIG5", :undef => :replace, :invalid => :replace))
	if (page.css("title").text =~ /權限錯誤/)
	  login()
	end
  end
  def getCourseIdList
    checkLogin()
    homework = Hash.new
    resp = getResp("http://ecourse.elearning.ccu.edu.tw/php/Courses_Admin/take_course.php?PHPSESSID=#{@session}&frame=1")
    page = Nokogiri::HTML(resp.body)
    page.css("table table td font a[href != \"#\"]").each { |x|
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


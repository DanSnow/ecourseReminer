#!/usr/bin/env ruby
#encoding:utf-8


require 'Qt'

require 'date'
require 'base64'

require_relative 'ecourseReminer.ui.rb'
require_relative 'ecourseHandler.rb'
require_relative 'ecourseReminer.rcc.rb'
require_relative 'setting.rb'

class EcourseReminer < Qt::Dialog
  include Ui
  slots "login()", "click(bool)", "logout()", "hideHomework()"
  def initialize(parent = nil)
    super
	Qt::TextCodec::setCodecForCStrings(Qt::TextCodec::codecForName("UTF-8"))
    @ui = EcourseReminerDia.new
    @ui.setupUi(self)

    @handler = EcourseHandler.new
    @homework = nil
    @selectHomework = []

    logoutAction = Qt::Action.new("Logout", self)
    exitAction = Qt::Action.new("Exit", self)

    menu = Qt::Menu.new

    menu.addAction(logoutAction)
    menu.addAction(exitAction)

    @ui.menuBtn.setMenu(menu)

    connect(logoutAction, SIGNAL("triggered()"), self, SLOT("logout()"))
    connect(exitAction, SIGNAL("triggered()"), self, SLOT("close()"))
    connect(@ui.loginBtn, SIGNAL("clicked()"), self, SLOT("login()"))
    connect(@ui.delBtn, SIGNAL("clicked()"), self, SLOT("hideHomework()"))

    @conf = Setting.new("../config/conf.yml")

    @ui.tB.removeItem(0)


    if @conf.key?("autoLogin") && @conf['autoLogin']
      if doLogin(@conf['id'], Base64::decode64(@conf['pass']))
        @ui.stack.setCurrentIndex(1)
        @ui.autoLoginChk.setChecked(true)
        return
      end
    end
    @ui.stack.setCurrentIndex(0)
  end

  def login
    if @ui.autoLoginChk.isChecked
      @conf['id'] = @ui.idLE.text.chomp
      @conf['pass'] =Base64::encode64(@ui.passLE.text.chomp)
      @conf['autoLogin'] = true
    else
      @conf['autoLogin'] = false
    end
    doLogin(@ui.idLE.text.chomp, @ui.passLE.text.chomp)
  end
  def doLogin(id = nil, pass = nil)
    begin
      @handler.login(id, pass)
      showHomework
      @ui.stack.setCurrentIndex(1)
    rescue RuntimeError => e
      Qt::MessageBox.information(self, "Error", "Login: #{e.message}")
      return false
    end
    return true
  end
  def showHomework
    getHomework if ! @homework
    count = 0
    @homework.each { |k, v|
      vbox = Qt::VBoxLayout.new
      v.each { |x|
        next if x.done
        btn = Qt::PushButton.new(x.name+" "+x.date.to_s)
        btn.setFlat(true)
        btn.setCheckable(true)
        btn.setChecked(false)
        connect(btn, SIGNAL("clicked(bool)"), self, SLOT("click(bool)"))
        if (x.date - Date::today).to_i <= 2
          btn.setStyleSheet("color:red")
        end
        vbox.addWidget(btn, 1, Qt::AlignRight|Qt::AlignVCenter)
        count += 1
      }
      widget = Qt::Widget.new
      widget.setLayout(vbox)
      @ui.tB.addItem(widget, k)
    }
    @ui.delBtn.setEnabled(false)
    @ui.uploadBtn.setEnabled(false)
    @ui.tB.setCurrentIndex(0)
    @ui.noifyL.setText("H: #{count}")
    @prevIndex=0
    @click = 0
  end
  def getHomework
    @homework = @handler.getHomework
    @conf['hideHomework'] = [] if !@conf.key?("hideHomework")
    @homework.each { |k, v|
      v.reject! {|x|
		@conf['hideHomework'].include?(x.name)
	  }
    }
  end
  def hideHomework
	reply = Qt::MessageBox::question(self, "Delete?", "Do you really want to delete it?\n Note : It can't be restore now", Qt::MessageBox.Yes, Qt::MessageBox.No)
    return if reply == Qt::MessageBox::No
	@selectHomework.each { |x|
	  @conf['hideHomework'] << x.text.split(" ")[0].encode("UTF-8", "UTF-8", :undef => :replace, :invalid => :replace)
	  x.setVisible(false)
	}
  end
  def click(x)
    if x
      @selectHomework << sender()
      @click += 1
    else
      @selectHomework.delete sender()
      @click -= 1
    end
    case @click
    when 0
      @ui.delBtn.setEnabled(false)
      @ui.uploadBtn.setEnabled(false)
    when 1
      @ui.delBtn.setEnabled(true)
      @ui.uploadBtn.setEnabled(true)
    else
      @ui.delBtn.setEnabled(true)
      @ui.uploadBtn.setEnabled(false)
    end
  end
  def logout
    @handler.logout
    @ui.stack.setCurrentIndex(0)
  end
  def closeEvent(event)
	@conf['hideHomework'].uniq!
    @conf.save("../config/conf.yml")
    reply = Qt::MessageBox::question(self, "Exit?", "Do you really want to exit?", Qt::MessageBox.Yes, Qt::MessageBox.No)
    if reply == Qt::MessageBox::Yes
      event.accept
    else
      event.ignore
    end
  end
end

app = Qt::Application.new(ARGV)
d = EcourseReminer.new
d.show
app.exec

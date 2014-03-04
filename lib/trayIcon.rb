#!/usr/bin/env ruby
# encoding: UTF-8

require 'thread'
require 'Qt'

require_relative 'trayIcon.rcc.rb'

class TrayIcon < Qt::SystemTrayIcon
  attr_reader :exitAction, :settingAction, :showAction
  def initialize(parent = nil)
    super(parent)
    setIcon(Qt::Icon.new(":img/icon128.png"))
    createMenu
  end

  private

  def createMenu()
    @menu = Qt::Menu.new
    @showAction = @menu.addAction("&Show")
    @settingAction = @menu.addAction("Setting")
    @exitAction = @menu.addAction("&Exit")
  end
end

if __FILE__ == $0
  app = Qt::Application.new(ARGV)
  tray = TrayIcon.new
  tray.exitAction.connect(SIGNAL("triggered()")){$qApp.quit}
  tray.show
  app.exec()
end

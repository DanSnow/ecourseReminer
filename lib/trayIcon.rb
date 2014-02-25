#!/usr/bin/env ruby
# encoding: UTF-8

require 'thread'
require 'Qt'

class TrayIcon < Qt::SystemTrayIcon
  def initialize(parent = nil)
    super(parent)
  end
end

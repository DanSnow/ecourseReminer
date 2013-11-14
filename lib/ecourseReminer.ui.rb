=begin
** Form generated from reading ui file 'ecourseReminer.ui'
**
** Created: Thu Nov 14 10:41:38 2013
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_EcourseReminerDia
    attr_reader :stack
    attr_reader :page
    attr_reader :layoutWidget
    attr_reader :verticalLayout
    attr_reader :horizontalLayout
    attr_reader :horizontalSpacer
    attr_reader :label
    attr_reader :idLE
    attr_reader :horizontalLayout_2
    attr_reader :label_2
    attr_reader :passLE
    attr_reader :autoLoginChk
    attr_reader :verticalSpacer
    attr_reader :horizontalLayout_3
    attr_reader :loginBtn
    attr_reader :clearBtn
    attr_reader :page_2
    attr_reader :layoutWidget1
    attr_reader :verticalLayout_2
    attr_reader :horizontalLayout_5
    attr_reader :stack2
    attr_reader :page_6
    attr_reader :layoutWidget2
    attr_reader :horizontalLayout_4
    attr_reader :uploadBtn
    attr_reader :delBtn
    attr_reader :page_7
    attr_reader :noifyL
    attr_reader :horizontalSpacer_2
    attr_reader :menuBtn
    attr_reader :tB
    attr_reader :page_3

    def setupUi(ecourseReminerDia)
    if ecourseReminerDia.objectName.nil?
        ecourseReminerDia.objectName = "ecourseReminerDia"
    end
    ecourseReminerDia.resize(365, 509)
    ecourseReminerDia.minimumSize = Qt::Size.new(365, 0)
    ecourseReminerDia.maximumSize = Qt::Size.new(365, 16777215)
    ecourseReminerDia.contextMenuPolicy = Qt::ActionsContextMenu
    ecourseReminerDia.styleSheet = ""
    @stack = Qt::StackedWidget.new(ecourseReminerDia)
    @stack.objectName = "stack"
    @stack.geometry = Qt::Rect.new(-5, -1, 371, 511)
    @page = Qt::Widget.new()
    @page.objectName = "page"
    @layoutWidget = Qt::Widget.new(@page)
    @layoutWidget.objectName = "layoutWidget"
    @layoutWidget.geometry = Qt::Rect.new(60, 150, 236, 161)
    @verticalLayout = Qt::VBoxLayout.new(@layoutWidget)
    @verticalLayout.objectName = "verticalLayout"
    @verticalLayout.setContentsMargins(0, 0, 0, 0)
    @horizontalLayout = Qt::HBoxLayout.new()
    @horizontalLayout.objectName = "horizontalLayout"
    @horizontalSpacer = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout.addItem(@horizontalSpacer)

    @label = Qt::Label.new(@layoutWidget)
    @label.objectName = "label"
    @label.alignment = Qt::AlignCenter

    @horizontalLayout.addWidget(@label)

    @idLE = Qt::LineEdit.new(@layoutWidget)
    @idLE.objectName = "idLE"

    @horizontalLayout.addWidget(@idLE)


    @verticalLayout.addLayout(@horizontalLayout)

    @horizontalLayout_2 = Qt::HBoxLayout.new()
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @label_2 = Qt::Label.new(@layoutWidget)
    @label_2.objectName = "label_2"
    @label_2.alignment = Qt::AlignCenter

    @horizontalLayout_2.addWidget(@label_2)

    @passLE = Qt::LineEdit.new(@layoutWidget)
    @passLE.objectName = "passLE"
    @passLE.echoMode = Qt::LineEdit::Password

    @horizontalLayout_2.addWidget(@passLE)


    @verticalLayout.addLayout(@horizontalLayout_2)

    @autoLoginChk = Qt::CheckBox.new(@layoutWidget)
    @autoLoginChk.objectName = "autoLoginChk"
    @autoLoginChk.checkable = true
    @autoLoginChk.tristate = false

    @verticalLayout.addWidget(@autoLoginChk)

    @verticalSpacer = Qt::SpacerItem.new(20, 40, Qt::SizePolicy::Minimum, Qt::SizePolicy::Expanding)

    @verticalLayout.addItem(@verticalSpacer)

    @horizontalLayout_3 = Qt::HBoxLayout.new()
    @horizontalLayout_3.objectName = "horizontalLayout_3"
    @loginBtn = Qt::PushButton.new(@layoutWidget)
    @loginBtn.objectName = "loginBtn"

    @horizontalLayout_3.addWidget(@loginBtn)

    @clearBtn = Qt::PushButton.new(@layoutWidget)
    @clearBtn.objectName = "clearBtn"

    @horizontalLayout_3.addWidget(@clearBtn)


    @verticalLayout.addLayout(@horizontalLayout_3)

    @stack.addWidget(@page)
    @page_2 = Qt::Widget.new()
    @page_2.objectName = "page_2"
    @layoutWidget1 = Qt::Widget.new(@page_2)
    @layoutWidget1.objectName = "layoutWidget1"
    @layoutWidget1.geometry = Qt::Rect.new(11, 2, 351, 501)
    @verticalLayout_2 = Qt::VBoxLayout.new(@layoutWidget1)
    @verticalLayout_2.objectName = "verticalLayout_2"
    @verticalLayout_2.setContentsMargins(0, 0, 0, 0)
    @horizontalLayout_5 = Qt::HBoxLayout.new()
    @horizontalLayout_5.objectName = "horizontalLayout_5"
    @stack2 = Qt::StackedWidget.new(@layoutWidget1)
    @stack2.objectName = "stack2"
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Preferred, Qt::SizePolicy::Preferred)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(1)
    @sizePolicy.heightForWidth = @stack2.sizePolicy.hasHeightForWidth
    @stack2.sizePolicy = @sizePolicy
    @stack2.minimumSize = Qt::Size.new(0, 10)
    @stack2.maximumSize = Qt::Size.new(16777215, 16777215)
    @page_6 = Qt::Widget.new()
    @page_6.objectName = "page_6"
    @layoutWidget2 = Qt::Widget.new(@page_6)
    @layoutWidget2.objectName = "layoutWidget2"
    @layoutWidget2.geometry = Qt::Rect.new(0, 0, 111, 31)
    @horizontalLayout_4 = Qt::HBoxLayout.new(@layoutWidget2)
    @horizontalLayout_4.objectName = "horizontalLayout_4"
    @horizontalLayout_4.setContentsMargins(0, 0, 0, 0)
    @uploadBtn = Qt::PushButton.new(@layoutWidget2)
    @uploadBtn.objectName = "uploadBtn"
    icon = Qt::Icon.new
    icon.addPixmap(Qt::Pixmap.new(":/img/img/Button-Upload-icon.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @uploadBtn.icon = icon

    @horizontalLayout_4.addWidget(@uploadBtn)

    @delBtn = Qt::PushButton.new(@layoutWidget2)
    @delBtn.objectName = "delBtn"
    icon1 = Qt::Icon.new
    icon1.addPixmap(Qt::Pixmap.new(":/img/img/Close-2-icon.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @delBtn.icon = icon1
    @delBtn.checkable = false
    @delBtn.flat = false

    @horizontalLayout_4.addWidget(@delBtn)

    @stack2.addWidget(@page_6)
    @page_7 = Qt::Widget.new()
    @page_7.objectName = "page_7"
    @stack2.addWidget(@page_7)

    @horizontalLayout_5.addWidget(@stack2)

    @noifyL = Qt::Label.new(@layoutWidget1)
    @noifyL.objectName = "noifyL"

    @horizontalLayout_5.addWidget(@noifyL)

    @horizontalSpacer_2 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_5.addItem(@horizontalSpacer_2)

    @menuBtn = Qt::PushButton.new(@layoutWidget1)
    @menuBtn.objectName = "menuBtn"
    @menuBtn.contextMenuPolicy = Qt::DefaultContextMenu
    icon2 = Qt::Icon.new
    icon2.addPixmap(Qt::Pixmap.new(":/img/img/Timeline-List-Grid-List-icon.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menuBtn.icon = icon2
    @menuBtn.flat = true

    @horizontalLayout_5.addWidget(@menuBtn)


    @verticalLayout_2.addLayout(@horizontalLayout_5)

    @tB = Qt::ToolBox.new(@layoutWidget1)
    @tB.objectName = "tB"
    @sizePolicy1 = Qt::SizePolicy.new(Qt::SizePolicy::Preferred, Qt::SizePolicy::Expanding)
    @sizePolicy1.setHorizontalStretch(0)
    @sizePolicy1.setVerticalStretch(5)
    @sizePolicy1.heightForWidth = @tB.sizePolicy.hasHeightForWidth
    @tB.sizePolicy = @sizePolicy1
    @page_3 = Qt::Widget.new()
    @page_3.objectName = "page_3"
    @page_3.geometry = Qt::Rect.new(0, 0, 349, 431)
    @tB.addItem(@page_3, Qt::Application.translate("EcourseReminerDia", "Page 1", nil, Qt::Application::UnicodeUTF8))

    @verticalLayout_2.addWidget(@tB)

    @stack.addWidget(@page_2)
    @label.buddy = @idLE
    @label_2.buddy = @passLE

    retranslateUi(ecourseReminerDia)
    Qt::Object.connect(@clearBtn, SIGNAL('clicked()'), @idLE, SLOT('clear()'))
    Qt::Object.connect(@clearBtn, SIGNAL('clicked()'), @passLE, SLOT('clear()'))

    @stack.setCurrentIndex(1)
    @stack2.setCurrentIndex(0)
    @tB.setCurrentIndex(0)


    Qt::MetaObject.connectSlotsByName(ecourseReminerDia)
    end # setupUi

    def setup_ui(ecourseReminerDia)
        setupUi(ecourseReminerDia)
    end

    def retranslateUi(ecourseReminerDia)
    ecourseReminerDia.windowTitle = Qt::Application.translate("EcourseReminerDia", "E-course Reminer", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("EcourseReminerDia", "ID :", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("EcourseReminerDia", "Password :", nil, Qt::Application::UnicodeUTF8)
    @autoLoginChk.text = Qt::Application.translate("EcourseReminerDia", "Auto Login", nil, Qt::Application::UnicodeUTF8)
    @loginBtn.text = Qt::Application.translate("EcourseReminerDia", "Login", nil, Qt::Application::UnicodeUTF8)
    @clearBtn.text = Qt::Application.translate("EcourseReminerDia", "Clear", nil, Qt::Application::UnicodeUTF8)
    @delBtn.text = ''
    @noifyL.text = Qt::Application.translate("EcourseReminerDia", "h:", nil, Qt::Application::UnicodeUTF8)
    @menuBtn.text = ''
    @tB.setItemText(@tB.indexOf(@page_3), Qt::Application.translate("EcourseReminerDia", "Page 1", nil, Qt::Application::UnicodeUTF8))
    end # retranslateUi

    def retranslate_ui(ecourseReminerDia)
        retranslateUi(ecourseReminerDia)
    end

end

module Ui
    class EcourseReminerDia < Ui_EcourseReminerDia
    end
end  # module Ui


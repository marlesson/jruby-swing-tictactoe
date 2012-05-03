include Java

java_import javax.swing.JButton
java_import javax.swing.BorderFactory
java_import javax.swing.JFrame
java_import javax.swing.JPanel
java_import javax.swing.JOptionPane
java_import javax.swing.JMenu
java_import javax.swing.JMenuBar
java_import javax.swing.JMenuItem
java_import java.awt.event.ActionListener
java_import java.awt.GridLayout;
java_import java.lang.System


class WindowTicTac < javax.swing.JFrame
  include ActionListener

  PLAYER_1 = "X"
  PLAYER_2 = "0"

  def initialize
    super "TIC TAC TOE"
    self.initUI
    restart
  end

  def initUI
    @panel = JPanel.new
    @panel.set_border BorderFactory::create_empty_border 3, 3, 3, 3
    @panel.set_layout GridLayout.new(3, 3)
    self.get_content_pane.add @panel
    
    #Initalize Menu
    @j_menu_item_restart = JMenuItem.new("Restart")
    @j_menu_item_restart.add_action_listener self

    @j_menu_item_about = JMenuItem.new("About")
    @j_menu_item_about.add_action_listener self

    @j_menu_item_exit = JMenuItem.new("Exit")
    @j_menu_item_exit.add_action_listener self

    @j_menu = JMenu.new("Help")
    @j_menu.add @j_menu_item_restart
    @j_menu.add @j_menu_item_about
    @j_menu.add @j_menu_item_exit

    @j_menu_bar = JMenuBar.new
    @j_menu_bar.add @j_menu

    setJMenuBar(@j_menu_bar)
    
    #Initialize Buttons
    @buttons = []
    (0...9).each do |index|
      
      button = JButton.new("")
      button.add_action_listener self
      @buttons << button
      @panel.add button

    end

    #initialize Window
    self.add @panel
    self.set_size 400, 400
    self.set_location_relative_to nil
    self.set_visible true
    self.set_default_close_operation JFrame::EXIT_ON_CLOSE
  end
  
  # Perform action
  def actionPerformed(e)
    case e.source
     when @j_menu_item_restart
        restart
     when @j_menu_item_about
          JOptionPane.showMessageDialog @panel, "About Java Swing TicTacToe - Marlesson",
          "Information", JOptionPane::INFORMATION_MESSAGE        
     when @j_menu_item_exit
        JavaLang::System.exit(0)
    end

    @buttons.each do |button|
      if e.source == button
        button.set_text((@player == 1) ? PLAYER_1 : PLAYER_2 )
        button.set_enabled false

        if winner?
          JOptionPane.showMessageDialog @panel, "Game Over. Player #{@player} Winner!!!",
          "Information", JOptionPane::INFORMATION_MESSAGE
          restart
        elsif @buttons.all?{|b| not b.enabled} #E TIE
          JOptionPane.showMessageDialog @panel, "Game Over. We Tied!",
          "Information", JOptionPane::INFORMATION_MESSAGE
          restart
        else
          next_player
        end
      end
    end
  end       

  private

  def restart
    @buttons.each do |button|
      button.set_enabled true
      button.set_text ""
    end
    @player = 1
  end

  def winner?
    win = [
      [0,1,2],
      [0,4,8],
      [0,3,6],
      [3,4,5],
      [6,7,8],
      [1,4,7],
      [2,5,8],
      [2,4,6],      
    ]

    win.any?{|w| w.all?{|i| @buttons[i].get_text.eql? PLAYER_1} or w.all?{|i| @buttons[i].get_text.eql? PLAYER_2} }
  end

  def next_player
    @player = (@player == 1) ? 2 : 1
  end
end

WindowTicTac.new
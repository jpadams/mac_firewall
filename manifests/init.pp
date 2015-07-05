class mac_firewall ($mode='on') {

  # returns one of { off, on, stealthmode, blockall }. stealthmode implies on.
  $curr_state = $::mac_firewall_state 

  case $mode {
    'off': {
      if $curr_state != 'off' {
        exec { 'mac firewall off':
          command => '/usr/bin/defaults write /Library/Preferences/com.apple.alf globalstate -int 0',
        }
      }
    }
    'on': {
      if $curr_state != 'on' { 
        exec { 'mac firewall on (not blockall)':
          command => '/usr/bin/defaults write /Library/Preferences/com.apple.alf globalstate -int 1',
        } ->
        exec { 'mac firewall stealthmode off':
          command => '/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode off',
        }
      }
    } 
    'stealthmode': {
      if $curr_state != 'stealthmode' {
        exec { 'mac firewall on (not blockall)':
          command => '/usr/bin/defaults write /Library/Preferences/com.apple.alf globalstate -int 1',
        } ->
        exec { 'mac firewall stealthmode on':
          command => '/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on',
        }
      }
    }
    'blockall': {
      if $curr_state != 'blockall' {
        exec { 'mac firewall blockall on':
          command => '/usr/bin/defaults write /Library/Preferences/com.apple.alf globalstate -int 2',
        }
      }
    }
    default: { fail('Value of mode param must be one of { off, on, stealthmode, blockall }') }
  }
}

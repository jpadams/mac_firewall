Facter.add('mac_firewall_state') do
  confine :osfamily => "Darwin"
  setcode do
    state = %x(/usr/bin/defaults read /Library/Preferences/com.apple.alf globalstate).chomp.to_i
    stealth = %x(/usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode)
    case state
    when 0
      'off'
    when 1
      if stealth.match(/disabled/i)
        'on'
      elsif stealth.match(/enabled/i)
        'stealthmode'
      end
    when 2
      'blockall'
    end
  end
end

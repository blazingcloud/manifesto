module Manifesto
  class Reporter
    class Summary < Reporter
      FORMAT = 'txt'

      def print_gem gem_name, info
        str = "#{gem_name} - version: #{info['version']}\n"
        info['licenses'].each_with_index do |license, i|
          str << "  #{license['type']} - "
          str << "percent matched: #{license['percent_matched']}%\n"
          str << "    diffs: #{license['diff']}\n" if license['diff']
        end
        str << "\n\n"
        str
      end
 
      def exceptions
        str = "\n\nEXCEPTIONS\n"
        exceptional_gems.each do |gem_name, info|
          str << "#{gem_name}, version #{info['version']} : "
          if info['licenses'].size == 0
            str <<  "NO LICENSE FOUND\n"
          else
            str << "UNKNOWN LICENSE\n"
          end
        end
        str
      end
    end
  end
end

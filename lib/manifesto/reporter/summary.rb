module Manifesto
  class Reporter
    class Summary < Reporter
      FORMAT = 'summary.txt'

      def print_gem gem_name, info
        str = "#{gem_name} - version: #{info['version']}\n"
        info['licenses'].each_with_index do |license, i|
          str << "  #{license['type']} - "
          str << "percent matched: #{license['percent_matched']}%\n"
        end
        str << "\n"
        str
      end
 
      def exceptions
        str = "\n\nEXCEPTIONS\n"
        exceptional_gems.each do |gem_name, info|
          str << "#{gem_name}, version #{info['version']} : NO LICENSE FOUND\n"
        end
        str
      end
    end
  end
end

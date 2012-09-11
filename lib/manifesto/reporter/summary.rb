module Manifesto
  class Reporter
    class Summary < Reporter
      FORMAT = 'summary.txt'

      def print_gem gem_name, info
        str = "#{gem_name} - version: #{info['version']}\n"
        info['licenses'].each_with_index do |license, i|
          if license['type']
            str << "  #{license['type'].gsub('_', ' ').upcase} - "
            str << "proximity: #{license['proximity']}; "
            str << "difference ratio: #{license['difference_ratio']}\n"
          else
            str << "  LICENSE UNKNOWN\n"
          end
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

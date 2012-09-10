module Manifesto
  class Reporter
    class Text < Reporter
      FORMAT = 'txt'

      def print_gem gem_name, info
        str = "#{gem_name}, version #{info['version']}, #{info['licenses'].size} license(s):\n"
        info['licenses'].each_with_index do |license, i|
          str << "    #{i+1}: #{license['body']}"
        end
        str
      end

      def exceptions
        str = "\n\nEXCEPTIONS\n"
        exceptional_gems.each do |gem_name, info|
          str << "#{gem_name}, version #{info['version']}, #{info['licenses'].size} license(s)\n"
        end
        str
      end
    end
  end
end

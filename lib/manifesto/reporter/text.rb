module Manifesto
  class Reporter
    class Text < Reporter
      FORMAT = 'txt'

      def print_gem gem_name, info
        str = "#{gem_name}, version #{info['version']}, #{info['licenses'].size} license(s):\n"
        info['licenses'].each_with_index do |license, i|
          str << "    type: #{license['type']}\n"
          str << "    percent matched: #{license['percent_matched']}%\n" if license['percent_matched']
          str << "#{license['body']}\n"
          str << "____________________\n"
        end
        str <<   "====================\n"
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

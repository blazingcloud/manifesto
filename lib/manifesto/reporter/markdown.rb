module Manifesto
  class Reporter
    class Markdown < Reporter
      FORMAT = 'md'

      def header
        str = "# Licence Manifesto\n\n"
        str << super
        str << "***\n"
      end

      def print_gem gem_name, info
        str = "## #{gem_name} - version: #{info['version']}\n"
        info['licenses'].each_with_index do |license, i|
          str << "    #{license['type']} - "
          str << "percent matched: #{license['percent_matched']}%\n"
          str << "    diffs: #{license['diff']}\n" if license['diff']
        end
        str << "***\n\n"
        str
      end
 
      def exceptions
        str = "***\n# EXCEPTIONS\n\n"
        exceptional_gems.each do |gem_name, info|
          str << "* #{gem_name}, version #{info['version']} : "
          if info['licenses'].size == 0
            str << "NO LICENSE FOUND\n"
          else
            str << "UNKNOWN LICENSE\n"
          end
        end
        str
      end

    end
  end
end

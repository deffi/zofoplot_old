class String
    # TODO Some Gnuplot terminals seem to have a bug with escape handling - try
    # to work around it using string concatenation ("foo"."bar")
    def to_gnuplot
        backslash   ="\\"
        single_quote="'"
        double_quote='"'

        escapes=[[backslash+backslash, '\\\\134'], [single_quote, '\\\\47'], [double_quote, '\\\\42']]

        s=self.dup
        escapes.each { |pattern, replacement| s.gsub! pattern, replacement }

        "\"#{s}\""
    end
end


#!/usr/bin/env ruby

# file: phoneme.rb

# resources
# =========
#
# * https://github.com/chrisvfritz/isabella
# * http://www.speech.cs.cmu.edu/tools/lmtool-new.html
#

class Phoneme

  attr_reader :to_s

  def initialize(s)

    @a = [
      {ey: /^a.[eo]/, ae: /^a.*/ },
      :b,
      {k: /^ca/, ch: /^(ch)/,s: /^ce|^c.*/},
      :d,
      {iy: /^ee|^e$/, eh: /^e.*/},
      :f,
      {jh: /^ge/, g: /^g.*/},
      {hh: /^h./},
      {ay: /^i$|^ie|^igh|^i.e/, ih: /^i.*/},
      :jh,
      {n: /^kn/, k: /^k.*/},
      :l,
      {m: /^(me)|^m/},
      {ng: /^ng/, n: /^n.*/},
      {ow: /^oa|^o$/, oy: /^oy/, aw: /^(ou)/, ah: /^om|^pl/},
      {p: /^p.*/},
      :q,
      :r,
      {sh: /^(sh)/, s: /^s.*/},
      {th: /^(th)/, t: /^t.*/},
      {uw: /^(u)b|^(u)de/, er: /^(ur)/, uh: /^u.*/},
      :v,
      {w: /^(wh)|^w.*/},
      {z: /^xy/, e: /^x.*/},
      {zh: /^zu/, z: /^z.*/}
    ]
    
    @to_s = phonemize(s).sub(/(e|iy) $/,'').rstrip.upcase
  end

  private

  def phonemize(s)

    s2 = s[0..2]

    r3 = ''

    r = @a.detect do |x|

      if x.is_a? Symbol then

        found = s2[0] == x.to_s
        r3 = x.to_s + ' '
        found

      elsif x.is_a? Hash

        x.detect do |sym,regex|

          found = s2[regex]
          r3 = found ? sym.to_s + ' ' : ''
          found
        end

      end
    end

    if r then

      new_s = $1 ? s[2..-1] : s[1..-1]

      if new_s.length > 0 then
        new_sym =  phonemize(new_s) 
        r3 + new_sym
      else
        r3
      end

    end  

  end
end


if __FILE__ == $0 then

  puts Phoneme.new(ARGV[0].first).to_s

end

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
      {ey: /^a.[eo]/, ah: /^a$/, ae: /^a.*/ },
      :b,
      {k: /^ca|^co/, ch: /^(ch)/,s: /^ce|^c.*/},
      {d: /^(de)$|^d.*/},
      {iy: /^(e[eayi])|^e$/, eh: /^e.*/},
      :f,
      {jh: /^ge/, :'' => /^(gh)/, g: /^g.*/},
      {hh: /^h.*/},
      {ay: /^i$|^(ie)|^igh|^i.e/, ih: /^i.*/},
      :jh,
      {n: /^(kn)/, k: /^k.*/},
      {l: /^(le)$|^l.*/},
      {m: /^me$|^(me)|^m/},
      {ng: /^(ng)/, n: /^n.*/},
      {ow: /^(oa)|^o$/, oy: /^(oy)/, uh: /^(oo)/, ao: /^(ou)/, aw: /^(o[uw])/, ah: /^om|^pl/, aa: /^(o).*/},
      {p: /^p.*/},
      :q,
      :r,
      {sh: /^(sh)/, z: /^(se)$/, s: /^s.*/},
      {th: /^(th)/, t: /^(te)$|^t.*/},
      {uw: /^(u)b|^(u)de/, er: /^(ur)/, ah: /^u.*/},
      :v,
      {uw: /^(wo)/, w: /^(wh)|^w.*/},
      {z: /^xy/, e: /^x.*/},
      :y,
      {zh: /^zu/, z: /^z.*/}
    ]
    
    @to_s = phonemize(s.downcase)\
        .sub(/ m iy$/,' m').sub(/th( iy)$/,'dh\1')\
        .sub(/th eh t /, 'th ey t ').sub(/^(y )ay( l )/,'\1iy\2')\
        .sub(/er iy$/,'er').rstrip.upcase
  end

  private

  def phonemize(s)

    s2 = s[0..2]

    r3 = ''

    r = @a.detect do |x|

      if x.is_a? Symbol then

        found = s2[0] == x.to_s
        r3 = x.to_s
        found

      elsif x.is_a? Hash

        x.detect do |sym,regex|

          found = s2[regex]
          r3 = found ? sym.to_s : ''
          found
        end

      end
    end

    if r then

      new_s = $1 ? s[2..-1] : s[1..-1]

      if new_s.length > 0  then
        
        new_sym =  phonemize(new_s)
        !r3.empty? ? r3 + ' ' + new_sym : new_sym
      else

        r3.strip
      end

    end  

  end
end


if __FILE__ == $0 then

  puts Phoneme.new(ARGV[0].first).to_s

end
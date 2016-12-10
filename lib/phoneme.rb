#!/usr/bin/env ruby

# file: phoneme.rb

# resources
# =========
#
# * https://github.com/chrisvfritz/isabella
# * http://www.speech.cs.cmu.edu/tools/lmtool-new.html
# * http://www.speech.cs.cmu.edu/cgi-bin/cmudict
#

class Phoneme

  attr_reader :to_s

  def initialize(s)

    @a = [
      {:'ey k ah n' => /^(acon)$/, ey: /^a.[eo]/, ah: /^a$|^al$/, ae: /^a.*/ },
      :b,
      {:'s k' => /^(sc)/},
      {:'s ih r iy' => /^(cere)/ },
      {:'k l ow' => /^(clo)/, k: /^c[oal]|^(ck)/, ch: /^(ch)/,s: /^ce|^c.*/},
      {dz: /^(ds)/, d: /^(d[de])$|^d.*/},
      {:'iy z' => /^(eese)$/, iy: /^(e[eayi])|^e$/}, 
      {:'eh k s' => /^x$|^(ex)/, eh: /^e.*/},
      :f,
      {jh: /^ge/, :'' => /^(gh)/, g: /^g.*/},
      {hh: /^h.*/},
      {ay: /^i$|^(ie)|^igh|^i.e/, ih: /^i.*/},
      :jh,
      {n: /^(kn)/, k: /^(ke)$|^k.*/},
      {l: /^(le)$|^l.*/},
      {m: /^me$|^(me)|^m/},
      {ng: /^(ng)/, nz: /^(ns)/, n: /^n.*/},
      {ow: /^(oa)|^o$/, oy: /^(oy)/, uh: /^(oo)/, ao: /^(ou)/, 
                        aw: /^(o[uw])/, ah: /^om|^pl/, aa: /^(o).*/},
      {p: /^p.*/},
      :q,
      {:'r ah t' => /(rrot)/, :'r ay n' => /^(rin)d/},
      :r,
      {sh: /^(sh)/,  s: /^(s[es])$|^s.*/},
      {:'t ah l' => /(t?tle)$/},
      {th: /^(th)/},
      {:'ch er' => /(ture)/}, 
      {:'t er' => /^(ter)/, t: /^(te)$|^t.*/},
      {:'y uw' => /^ut[eu]/},      
      {uw: /^(u)b|^(u)de/, er: /^(ure?)/, ah: /^u.*/},
      :v,
      {uw: /^(wo)/, w: /^(wh)|^w.*/},
      {z: /^xy/,  e: /^x.*/},
      :y,
      {zh: /^zu/, z: /^z.*/}
    ]
    
    @to_s = phonemize(s.downcase)\
        .sub(/ ([mn]) iy$/,' \1').sub(/th( iy)$/,'dh\1')\
        .sub(/th eh t /, 'th ey t ').sub(/^([y] )ay( l )/,'\1iy\2').rstrip.upcase
  end

  private

  def phonemize(s)
    #puts 's: ' + s.inspect
    s2 = s[0..3]

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

      new_s = $1 ? s[($1).length..-1] : s[1..-1]

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
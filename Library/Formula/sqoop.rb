require 'formula'

class Sqoop < Formula
  url 'https://github.com/downloads/cloudera/sqoop/sqoop-1.3.0.tar.gz'
  homepage 'http://www.cloudera.com/sqoop'
  md5 'ba7d803ff7764bc6f7528c0d7a51e9fd'

  depends_on 'hive'

  def shim_script target
    <<-EOS.undent
      #!/bin/bash
      exec #{libexec}/bin/#{target} $*
    EOS
  end

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[bin conf lib ]
    libexec.install Dir['*.jar']
    bin.mkpath

    Dir["#{libexec}/bin/*"].each do |b|
      n = Pathname.new(b).basename
      (bin+n).write shim_script(n)
    end
  end

end

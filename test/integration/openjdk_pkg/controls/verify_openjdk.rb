java_version = input('java_version', description: 'Which version of java should be installed')

control 'Java is installed & linked correctly' do
  impact 1.0
  title 'Installed'
  desc 'Java is installed & linked correctly'
  describe command('java -version 2>&1') do
    its('stdout') { should match java_version.to_s }
  end

  describe command('update-alternatives --display java') do
    if java_version.to_i < 11
      its('stdout') { should match %r{\/usr\/lib\/jvm\/java} }
    else
      its('stdout') { should match %r{\/usr\/lib\/jvm\/jre} }
    end
  end
end

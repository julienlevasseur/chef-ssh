describe file('/root/.ssh/id_rsa') do
  it { should exist }
  it { should be_owned_by 'root' }
end
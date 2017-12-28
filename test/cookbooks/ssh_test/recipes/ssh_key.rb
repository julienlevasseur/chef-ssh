# Author: Julien Levasseur

include_recipe 'ssh'

ssh_key 'id_rsa' do
  path '/root/.ssh'
end

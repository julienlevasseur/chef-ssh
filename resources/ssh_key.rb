# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :ssh_key
provides :ssh_key

property :name, String, name_property: true
property :path, String

default_action :create

action :create do
  converge_by "Creating #{new_resource.path}/#{new_resource.name} SSH key." do
    begin
      system("ssh-keygen -t rsa -q -f #{path}/#{new_resource.name} -P \"\"")
      Chef::Log.debug("#{new_resource.name}: Creating [#{new_resource.path}/#{new_resource.name}]")
    rescue
      Chef::Log.error("Unable to create #{new_resource.path}/#{new_resource.name}")
    end
  end
end

action :delete do
  converge_by "Deleting #{new_resource.path}/#{new_resource.name} SSH key." do
    begin
      File.delete("#{new_resource.path}/#{new_resource.name}")
      File.delete("#{new_resource.path}/#{new_resource.name}.pub")
      Chef::Log.debug("#{new_resource.name}: Deleting [#{new_resource.path}/#{new_resource.name}] key pair")
    rescue
      Chef::Log.error("Unable to delete #{new_resource.path}/#{new_resource.name} / #{new_resource.name}.pub")
    end
  end
end

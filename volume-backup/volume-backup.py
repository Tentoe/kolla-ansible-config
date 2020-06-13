import openstack

# Initialize and turn on debug logging
openstack.enable_logging(debug=True)

# Initialize cloud
conn = openstack.connect(cloud='openstack')

help(conn.compute.servers())

# for server in conn.compute.servers():
#     print(server.to_dict())
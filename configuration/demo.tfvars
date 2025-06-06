#Referenced common across modules
owner_custom = "hamza"
purpose_custom = "demo"

#Referenced in resource-group module
owner = "hamza.zarfaoui@meinhardtgroup.com"
purpose = "test"
location = "australiaeast"
org = "Meinhardt"

current_user = "Hamza.Zarfaoui@meinhardtgroup.com"

#Referenced in network module
address_space = ["10.10.0.0/21"]

subnets = {
    subnet1 = {
        name = "public_subnet"
        address_space = ["10.10.1.0/26"]
        subnet_delegation = true
        }

    subnet2 = {
        name = "private_subnet"
        address_space = ["10.10.1.64/26"]
        subnet_delegation = true
        }

    subnet3 = {
        name = "privatelink_subnet"
        address_space = ["10.10.1.128/26"]
        subnet_delegation = false
        }
    
    subnet4 = {
        name = "AzureFirewallSubnet"
        address_space = ["10.10.1.192/26"]
        subnet_delegation = false
        }
}

nsg = {
    public_nsg = {
        name = "public_nsg"
        }

    private_nsg = {
        name = "private_nsg"
        }
}

# private_link_subnet = "/subscriptions/58f627af-5f2f-4f24-b8b3-67712c182a5c/resourceGroups/rg-raghav-demo/providers/Microsoft.Network/virtualNetworks/raghav-demo-vnet/subnets/privatelink_subnet"

# fw_subnet_id = "/subscriptions/58f627af-5f2f-4f24-b8b3-67712c182a5c/resourceGroups/rg-raghav-demo/providers/Microsoft.Network/virtualNetworks/raghav-demo-vnet/subnets/AzureFirewallSubnet"

# rt_public_subnet = "/subscriptions/58f627af-5f2f-4f24-b8b3-67712c182a5c/resourceGroups/rg-raghav-demo/providers/Microsoft.Network/virtualNetworks/raghav-demo-vnet/subnets/public_subnet"
    
# rt_private_subnet = "/subscriptions/58f627af-5f2f-4f24-b8b3-67712c182a5c/resourceGroups/rg-raghav-demo/providers/Microsoft.Network/virtualNetworks/raghav-demo-vnet/subnets/private_subnet"
resource "azurerm_public_ip" "frontend" {
  name                = "frontend-pip"
  location            = "Denmark East"
  resource_group_name = "Denmark-east-rg"
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "frontend" {
  name                = "frontend-pip"
  location            = "Denmark East"
  resource_group_name = "Denmark-east-rg"
  allocation_method   = "Static"
  domain_name_label   = "youruniquename123"
}

resource "azurerm_network_interface" "frontend" {
  name                = "frontend-nic"
  location            = "Denmark East"
  resource_group_name = "Denmark-east-rg"

  ip_configuration {
    name                          = "frontend-nic"
    subnet_id                     = "/subscriptions/7ba54b86-56e1-4dd5-a544-23df4caeb2aa/resourceGroups/Denmark-east-rg/providers/Microsoft.Network/virtualNetworks/image-vm-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend.id
  }
}
resource "azurerm_linux_virtual_machine" "frontend" {
  name                = "frontend-vm"
  resource_group_name = "Denmark-east-rg"
  location            = "Denmark East"
  size                = "Standard_B1s"
  #admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.frontend.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_username = "devops"
  admin_password = "Devops@12345"
  disable_password_authentication = "false"

  source_image_id = "/subscriptions/7ba54b86-56e1-4dd5-a544-23df4caeb2aa/resourceGroups/Denmark-east-rg/providers/Microsoft.Compute/galleries/rhel10.1/images/1.0.0/versions/1.0.0"

  secure_boot_enabled = "true"
  vtpm_enabled = "true"

}

resource "azurerm_dns_a_record" "frontend" {
  name                = "frontend-dev"
  zone_name           = "kubek8.online"
  resource_group_name = "Denmark-east-rg"
  ttl                 = 30
  records             = [azurerm_network_interface.frontend.private_ip_address]
}

resource "azurerm_network_interface" "sqlserver" {
  name                = "sqlserver-nic"
  location            = "Denmark East"
  resource_group_name = "Denmark-east-rg"

  ip_configuration {
    name                          = "sqlserver-nic"
    subnet_id                     = "/subscriptions/7ba54b86-56e1-4dd5-a544-23df4caeb2aa/resourceGroups/Denmark-east-rg/providers/Microsoft.Network/virtualNetworks/image-vm-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "sqlserver" {
  name                = "sqlserver-vm"
  resource_group_name = "Denmark-east-rg"
  location            = "Denmark East"
  size                = "Standard_B1s"
  #admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.sqlserver.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_username = "devops"
  admin_password = "Devops@12345"
  disable_password_authentication = "false"

  source_image_id = "/subscriptions/7ba54b86-56e1-4dd5-a544-23df4caeb2aa/resourceGroups/Denmark-east-rg/providers/Microsoft.Compute/galleries/rhel10.1/images/1.0.0/versions/1.0.0"

  secure_boot_enabled = "true"
  vtpm_enabled = "true"

}

resource "azurerm_dns_a_record" "sqlserver" {
  name                = "sqlserver-dev"
  zone_name           = "kubek8.online"
  resource_group_name = "Denmark-east-rg"
  ttl                 = 30
  records             = [azurerm_network_interface.sqlserver.private_ip_address]
}


resource "azurerm_network_interface" "catalogue" {
  name                = "catalogue-nic"
  location            = "Denmark East"
  resource_group_name = "Denmark-east-rg"

  ip_configuration {
    name                          = "catalogue-nic"
    subnet_id                     = "/subscriptions/7ba54b86-56e1-4dd5-a544-23df4caeb2aa/resourceGroups/Denmark-east-rg/providers/Microsoft.Network/virtualNetworks/image-vm-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "catalogue" {
  name                = "catalogue-vm"
  resource_group_name = "Denmark-east-rg"
  location            = "Denmark East"
  size                = "Standard_B1s"
  #admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.catalogue.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_username = "devops"
  admin_password = "Devops@12345"
  disable_password_authentication = "false"

  source_image_id = "/subscriptions/7ba54b86-56e1-4dd5-a544-23df4caeb2aa/resourceGroups/Denmark-east-rg/providers/Microsoft.Compute/galleries/rhel10.1/images/1.0.0/versions/1.0.0"

  secure_boot_enabled = "true"
  vtpm_enabled = "true"

}

resource "azurerm_dns_a_record" "catalogue" {
  name                = "catalogue-dev"
  zone_name           = "kubek8.online"
  resource_group_name = "Denmark-east-rg"
  ttl                 = 30
  records             = [azurerm_network_interface.catalogue.private_ip_address]
}

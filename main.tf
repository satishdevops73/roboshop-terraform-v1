resource "azurerm_network_interface" "frontend" {
  name                = "frontend-nic"
  location            = "Denmark East"
  resource_group_name = "Denmark-east-rg"

  ip_configuration {
    name                          = "frontend-nic"
    subnet_id                     = "/subscriptions/7ba54b86-56e1-4dd5-a544-23df4caeb2aa/resourceGroups/Denmark-east-rg/providers/Microsoft.Network/virtualNetworks/image-vm-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "frontend" {
  name                = "frontend-vm"
  resource_group_name = "Denmark-east-rg"
  location            = "Denmark East"
  size                = "Standard_D2s_v3"
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
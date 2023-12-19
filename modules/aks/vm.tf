resource "azurerm_public_ip" "bastion_pub_ip" {
  name                = "bastion-publicip"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "bation_nic" {
  name                = "bastion-nic"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.cluster_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_pub_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "bastion" {
  name                = "bastion-vm"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  size                = "standard_b2s"
  admin_username      = var.bastion_username
  admin_password      = var.bastion_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.bation_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

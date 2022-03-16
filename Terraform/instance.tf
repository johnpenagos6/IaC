resource "aws_instance" "example" {
  ami             = "ami-04505e74c0741db8d"
  instance_type   = "t2.micro"
  key_name= "Keygen"
  security_groups = ["launch-wizard-1"]
  tags = {
    Name = "john-ec2"
  }

  provisioner "remote-exec" {
    inline = [
      "touch prueba.txt"
    ]
  }

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/johnpenagos/.ssh/Keygen")
      timeout     = "4m"
   }
  
}

resource "aws_key_pair" "deployer" {
  key_name   = "Keygen"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrCIMPWr+J3+eZ/c1RDv2OYSGg5KsZ2h+eoam5I49UpDQdCob3bl1vJ7Vt1hrFinGO2FdggEvaRpPMjGHHc2DofcH9Nx3qDwgneewgC1QOo07vXcuS0tMXUbZvG3sOw3ZsduekZ6H0R5wlp25kbnJ1OUFhN8gXB6+dJIfFOGfhvpVtoF8CZJ9XzCU/YbCJjSLrMDbWVK4iIB7WdkRdf0iuHy/OeulDV6ZCndPRP90kIqLlniOSV+twoiRwNhYcsURnxqCezujDGjt9MDzgGcSIi91NErEk3/h0c9ETBL+Bg93Iums5wMZLawgVBb39ul9ebTCipeZHQ+ajEEjweKlguSsWlqwcLoJHIXJ+NAD9xW5kteR/NgUDCKOtCxaHW4aSxEdKUgaRRqQJshxWRznmCoNkghCSqGT8HqOtNqxmQOKXiMe3CInLLvjKgLnrkV/BixRjQhBJO732Bx8m/jWAgAdBo01gDWZJeBTaJj5aEIg9Xp/mZnZ3qV3S1jVqmZLrsMkWV7Y7faCrRnJGWGdTDkJ0AuNz90IROxo3cbUoKA6pbpXUraMuuoNg6DuLtzTxDKHj+PgrI9R/YLKhErOH0eyts67udu6oPxMP6YMIuY8nPXfquvs6AZGMrGaBZ5DYyjtUiuuDiHlE4hFkvzOdXDVcRefDZXcYx4Y6O3H3Iw== johnpenagos@DESKTOP-9JCR9EL"
}

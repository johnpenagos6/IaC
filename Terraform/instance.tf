resource "aws_instance" "example" {
  ami             = "ami-04505e74c0741db8d"
  instance_type   = "t2.micro"
  key_name        = "Keygen"
  security_groups = ["launch-wizard-1"]
  tags = {
    Name = "test-php"
  }

  provisioner "remote-exec" {
    inline = [
      "touch test.txt",
      "sudo apt-get update",
      "sudo apt-get install ca-certificates curl gnupg lsb-release",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update -y",
      "sudo apt-get -y install docker-ce docker-ce-cli containerd.io",
      "git clone https://github.com/AnamisVac/Login.git",
      "cd Login/",
      "sudo docker build -t demo:1.0 .",
      "sudo docker run -d -p 8080:80 --name app-php demo:1.0"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/bay/.ssh/keyWSL")
    timeout     = "4m"
  }

}

resource "aws_key_pair" "deployer" {
  key_name   = "Keygen"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQChQIKTk9iabfZnzAibFccaaGLDs9fBaWIjKHxXB8EbEW3rEoL9vuSr5lNorR5WycEui1gUPSq5aiTGcy1riAd0lolpAsUXLZD+HxRpcsJIpjVzUvFLtkgDFeu6zuwFMvKayQ9pkcUvAppC8g4i/uY3TE0gPx0PKF1XfqPOlbkthXxveV8Ix1A6WeHr3klNP5pg3dHMCHKVte4R9jCtOqmWQAG/3dGfs7ZtFX73N7dTsxruGcYcLcNfHAJ41abQ1hMyGxqBXvam0yHnrmPNiLpLFOCuVslAikDeUcWZUjx4+VIl2peH8gYwMHdGQCHolFrKBoJhGBDy8llP+Fhx9Oiq91+qnXAoqpd8bKbZvUEZ3J6SqpxhrxQeZ4VnkL+UQ/zft012NPJ/lrVwKSYbZu8iTmlorAA4NvZR3hT+l0wvMG9yuJ/lh3Z8jg5IMddQEsVx6y97CJY/YwlvNTRbpjCSvm+N/wyDD0NXV80tPpdgw06oR2Sj1Tko5XvkiB6UjLjB6dpXDyHESBoTpw5fFRU+W+J4tvy0ag/Uz306Cc9wj3tBo+eZ9cvgg2fTNuZZ37/cCFwZjmzD5+z/joKlVHRB4F1HDUpouYb97isosZaUW8arrF+mGzNAAE2UD0sIzAbdt86dOprDoZNjCohtwA7G7kdRxqSvN2+ilcdTXaPEVw== keyWSL"
}

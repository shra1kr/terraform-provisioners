resource "aws_instance" "DB" {
    ami = "ami-090252cbe067a9e58"
    vpc_security_group_ids = ["sg-018a7f01c6abc8b7d"]
    instance_type = "t3.micro"

    # provisioners will run when you are creating resources
    # they will not run once the resources are created
    provisioner "local-exec" {
        command = "echo The server's IP address is ${self.private_ip} > private_ips.txt" # self is aws_instance.DB
    }

    # provisioner "local-exec" {
    #     command = "ansible-playbook -i private_ips.txt web.yaml" # self is aws_instance.DB
    # }

    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = self.public_ip
    }

     provisioner "remote-exec" {
        inline = [
            "sudo dnf install ansible -y",
            "sudo dnf install nginx -y",
            "sudo systemctl start nginx"
        ]
    }

    tags = {
        Name = "DB"
        createdby = "shravan kumar"
    }
}    
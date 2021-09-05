output "vpc" {
  value = data.aws_vpc.main
}

output "subnets" {
  value = {
    public  = aws_subnet.public
    private = aws_subnet.private
  }
}
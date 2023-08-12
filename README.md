# terraform-study
terraformの学習用リポジトリ

## Terraform に関するコマンド

1. terraform init (Terraform 環境の初期化)

terraform -chdir="./backend/terraform" init -backend-config="bucket=aufgiesser-terraform"

2.  terraform plan (作成されるリソース or 既存のリソースの変更点 の確認)

terraform -chdir="./backend/terraform" plan -var-file="./vars.tfvars"

3.  terraform apply (リソースの作成 or 既存リソースの変更 を実施)

terraform -chdir="./backend/terraform" apply -var-file="./vars.tfvars"

4.  terraform destory

- terraform -chdir="./backend/terraform" plan -destory -var-file="./vars.tfvars" で削除されるリソースを確認
- terraform -chdir="./backend/terraform" destroy -var-file="./vars.tfvars"
  ※ 実案件では上記コマンドは使わず、destroy したいリソースのみをコメントアウトして apply する
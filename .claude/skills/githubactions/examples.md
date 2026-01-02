# GitHub Actions code Examples

## Necessarily use commit hash

Do NOT use tag value

```yaml
# Good Example
- uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0

# Bad Example
- uses: actions/checkout@v5
```

## Always fix runtime machine version

```yaml
# Good
runs-on: ubuntu-24.04

# Not Good
runs-on: ubuntu-latest
```

## Always set timeout

```yaml
jobs:
  detect:
    timeout-minutes: 5
```
You can use max timeout minute is `60`.

## Set Concurrency


```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true # 実行中ワークフローのキャンセルを有効化
```

## Simple code techniques

1. use Environments

```yaml
# Simple and Better: case of using GitHub Environments
- run: HOGE_VALUE="${{ vars.HOGE_VALUE }}"

# Bit redundant: case of nonuse GitHub Environments
- run:
      if [ "開発環境" ]; then
          HOGE_VALUE="dev"
      else if [ "本番環境" ]; then
          HOGE_VALUE="prod"
      fi
```

2. use matrix strategy

```yaml
ci:
    needs: set-matrix
    strategy:
      fail-fast: false
      max-parallel: 10
      matrix:
        dir: ${{fromJson(needs.set-matrix.outputs.target-dirs-production)}} # 特定のディレクトリに対して同じ処理を行う
    steps:
      - run: terraform init
```

## Composite actions example code

this composite actions example is to

- setup terraform
- authorize aws

```yaml
name: "AWS Terraform Setup"
description: "Sets up AWS credentials and initializes Terraform for a given directory"

inputs:
  directory:
    description: "Terraform directory to process"
    required: true
    default: ""
  use-terraform-stdout:
    description: "Whether Use stdout resource, default is true"
    required: false
    default: "true"
  aws-iam-role-arn-map-json:
    description: "JSON map of account keys to IAM role ARNs"
    required: true
    default: ""
  aws-region:
    description: "AWS Region"
    required: false
    default: ap-northeast-1

outputs:
  account-key:
    description: "Account key extracted from versions.tf"
    value: ${{ steps.aws-account.outputs.account-key }}
  account-id:
    description: "AWS account ID from the role ARN map"
    value: ${{ steps.aws-account.outputs.ACCOUNT_ID }}
  terraform-version:
    description: "Terraform version from versions.tf"
    value: ${{ steps.tf-version.outputs.version }}

runs:
  using: "composite"
  steps:
    - name: detect-account
      id: aws-account
      shell: bash
      working-directory: ${{ inputs.directory }}
      run: |
        # Extract account key from versions.tf comment
        if [ ! -f "versions.tf" ]; then
          echo "Error: versions.tf not found in ${{ inputs.directory }}"
          exit 1
        fi

        ACCOUNT_KEY=$(awk '/^# Account:/ {print $3}' versions.tf | head -1)

        if [ -z "$ACCOUNT_KEY" ]; then
          echo "Error: Could not extract account key from versions.tf"
          exit 1
        fi

        echo "Account key: $ACCOUNT_KEY"
        echo "account-key=$ACCOUNT_KEY" >> $GITHUB_OUTPUT

        # Get account ID from secrets using the extracted account key
        ACCOUNT_ID=$(echo ${{ inputs.aws-iam-role-arn-map-json }} | jq -r --arg key "$ACCOUNT_KEY" '.[$key]')
        echo "ACCOUNT_ID=$ACCOUNT_ID" >> $GITHUB_OUTPUT

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@0be22f94c34623c570f2c1479d3a28b5678673c7 # v5.0.0
      with:
        role-to-assume: "arn:aws:iam::${{ steps.aws-account.outputs.ACCOUNT_ID }}:role/githubactions-terraform"
        aws-region: ${{ inputs.aws-region }}
        role-session-name: terraform-${{ github.sha }}

    - name: Get Terraform version
      id: tf-version
      shell: bash
      working-directory: ${{ inputs.directory }}
      run: |
        # Extract terraform version from versions.tf
        if [ ! -f "versions.tf" ]; then
          echo "Error: versions.tf not found in ${{ inputs.directory }}"
          exit 1
        fi

        TERRAFORM_VERSION=$(grep 'required_version' versions.tf | sed -n 's/.*required_version = "\([^"]*\)".*/\1/p' | head -1)

        if [ -z "$TERRAFORM_VERSION" ]; then
          echo "Error: Could not extract terraform version from versions.tf"
          exit 1
        fi

        echo "Terraform version: $TERRAFORM_VERSION"
        echo "version=$TERRAFORM_VERSION" >> $GITHUB_OUTPUT

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@b9cd54a3c349d3f38e8881555d616ced269862dd # v3.1.2
      with:
        terraform_version: ${{ steps.tf-version.outputs.version }}
        terraform_wrapper: ${{ inputs.use-terraform-stdout }}

    - name: Terraform Init
      shell: bash
      working-directory: ${{ inputs.directory }}
      run: terraform init -input=false
```

## Reusable workflow example code

This example shows:

- authorize aws
- build docker image
- push image to ecr
- update aws lambda image


```yaml
name: lambda deploy
on:
  workflow_call:
    inputs:
      function-name:
        description: deploy target lambda function name
        required: true
        type: string
      repository-name:
        description: image repository name
        required: true
        type: string
      build-context:
        description: path to build context path
        required: false
        type: string
        default: '.'
      dockerfile-path:
        description: path to Dockerfile
        required: false
        type: string
        default: './Dockerfile'
      build-platforms:
        description: specify build platforms
        required: false
        type: string
        default: 'linux/arm64'
    secrets:
      aws-role-arn:
        description: aws role arn
        required: true

jobs:
  build-deploy:
    name: build image and deploy Lambda
    runs-on: ubuntu-24.04
    permissions:
      id-token: write
      contents: read
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
      - uses: aws-actions/configure-aws-credentials@a03048d87541d1d9fcf2ecf528a4a65ba9bd7838 # v5.0.0
        with:
          aws-region: ${{ vars.AWS_REGION }}
          role-to-assume: ${{ secrets.aws-role-arn }}
      - name: Set up QEMU
        uses: docker/setup-qemu-action@29109295f81e9208d7d86ff1c6c12d2833863392 # tag=v3.6.0
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@e468171a9de216ec08956ac3ada2f0791b6bd435 #tag=v3.11.1
      - id: login-ecr
        name: Login to Amazon ECR
        uses: aws-actions/amazon-ecr-login@062b18b96a7aff071d4dc91bc00c4c1a7945b076 # tag=v2.0.1
      - name: Build and push
        uses: docker/build-push-action@263435318d21b8e681c14492fe198d362a7d2c83 # tag=v6.18.0
        with:
          push: true
          provenance: false # See. https://blog.kengo-toda.jp/entry/2023/01/21/204504
          context: ${{ inputs.build-context }}
          file: ${{ inputs.dockerfile-path }}
          platforms: ${{ inputs.build-platforms }}
          tags: ${{ steps.login-ecr.outputs.registry }}/${{ inputs.repository-name }}:${{ github.sha }}
      - name: Deploy Lambda function with container image
        uses: aws-actions/aws-lambda-deploy@29ea35c124579506cf0475e20df36198eb670d89 # v1.1.0
        with:
          function-name: ${{ inputs.function-name }}
          package-type: Image
          image-uri: ${{ steps.login-ecr.outputs.registry }}/${{ inputs.repository-name }}:${{ github.sha }}
```
## GitHub Actions Coding Guidelines

Implementing GitHub Actions(yml, yaml file), follow the guidelines below.

### Commons
#### Security

- Using Third-Party Actions, references by full commit hash. Do not use tag value.
  - Reason: Since tag is mutable, can be maliciously modified. On the other hand, commit hash is immutable.
  - Tips: Using [pinact](https://github.com/suzuki-shunsuke/pinact), You can convert tag value into full commit hash if installed.

- Use Latest Tag. Check Tag/Release by `gh` command.
- Apply actions according to the following priority
  - 1. My Organization Custom Actions
  - 2. Verified thrid-party actions
  - 3. others
- If necessary, use write [permission](https://docs.github.com/ja/actions/reference/workflows-and-actions/workflow-syntax#permissions)
  - Default permission's `read-only`
  - Set value for each key
  - Do not use `write` and `write-all`

#### Maintainability

- Make the most of [GitHub Environments](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments)
- Set specific runner version
  - do not use latest version
  - Reason: latest tag is unstable and its target can change unexpectedly.
- Make the most of [matrix strategy](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/run-job-variations)

#### Cost Cut

- Set `timeout-minutes`
  - Reason: default timeout is 6hour. Should you implement infinite loop and not set timeout-minutes, run for 6 hours(you have to pay for 6 hours process, what a mess!).
- Set `concurrencycancel-in-progress` to prevent duplicate execution

- In actions file, you have to write below:
  - actions or workflow description
  - description in inputs
  - needed permission(reusable workflow)

### Composite Actions / Reusable Workflow

- Create README file with actions/workflow. Write below.
  - Description
  - Input / Output parameter
  - Environment variables
  - how to use(example)


### Reusable workflow only

- Use GitHub Environments Variables as `variables`
  - Either of the following methods:
    - 1. (Recommended) Set `environments` as input varialbes, and other variables refers GitHub Environments variables as`${{ vars.HOGE }}`.
    - 2. Defined essential input variables

- Set minimum `secrets` parameter
  - Do not use `secrets: inherit`
# 1. Tạo action cơ bản

```
# Tạo thư mục workflow
mkdir .github/workflows
```
Tạo action bất kỳ
```
# macos
touch github-actions-demo.yml
# windows
type nul > "github-actions-demo.yml"
```

Nội dung file yml

```
name: GitHub Actions Demo
run-name: ${{ github.actor }} is testing out GitHub Actions 🚀
on: [push]
jobs:
  Explore-GitHub-Actions:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
      - run: echo "🐧 This job is now running on a ${{ runner.os }} server hosted by GitHub!"
      - run: echo "🔎 The name of your branch is ${{ github.ref }} and your repository is ${{ github.repository }}."
      - name: Check out repository code
        uses: actions/checkout@v3
      - run: echo "💡 The ${{ github.repository }} repository has been cloned to the runner."
      - run: echo "🖥️ The workflow is now ready to test your code on the runner."
      - name: List files in the repository
        run: |
          ls ${{ github.workspace }}
      - run: echo "🍏 This job's status is ${{ job.status }}."
```

### Check result

https://prnt.sc/LSVxvXVEowAG



# 2. Tạo secrets variable

# 3. Tạo action auto copy to FTP
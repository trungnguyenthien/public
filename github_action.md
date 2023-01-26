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

```yml
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

### Giải thích

* Mỗi file yml là 1 **WORKFLOW**: Workflow sẽ được trigger bởi event `on` (). 
* Mỗi workflow có nhiều **JOB**: Mỗi job chạy trên mỗi runner riêng được define bằng `runs-on` (). Runner là server để thực thi các job.
* Mỗi job có nhiều **STEP**, được define trong `steps`. Mỗi step có thể đơn giản là các shell script được execute bằng `run` , hoặc step có thể là 1 **ACTION** nếu đó là 1 custom app như ftp_deploy dùng cho các thao tác phức tạp hơn.



### Check result

![image-20230126154108554](https://tva1.sinaimg.cn/large/008vxvgGgy1hah55wyhxxj30pp0djwfx.jpg)



# 2. Tạo secrets variable

![image-20230126140639745](../Library/Application Support/typora-user-images/image-20230126140639745.png)

### Env Secrets

Sử dụng cho tất cả repo.

Get bằng

```
 ${{ env.ftp_username }}
```

### Repo Secrets

Sử dụng riêng cho 1 repo.

Get bằng

```
 ${{ secrets.ftp_username }}
```





# 3. Tạo action auto copy to FTP

Sample

```yml
on: push
name: 🚀 Deploy website on push
jobs:
  web-deploy:
    name: 🎉 FTP Deploy
    runs-on: ubuntu-latest
    steps:
    - name: 🚚 Get latest code
      uses: actions/checkout@v2

    - name: Use Node.js 16
      uses: actions/setup-node@v2
      with:
        node-version: '16'
      
    - name: 🔨 Build Project
      run: |
        npm install
    
    - name: 📂 Sync files
      uses: SamKirkland/FTP-Deploy-Action@4.3.3
      with:
        server: ftp.dauden.cloud
        port: 21
        protocol: ftp
        username: ${{ secrets.ftp_username }}
        password: ${{ secrets.ftp_password }}
        server-dir: node/app01/
        local-dir: ./
        exclude: |
          **/.git*
          **/.git*/**
          **/node_modules/**
          fileToExclude.txt
```


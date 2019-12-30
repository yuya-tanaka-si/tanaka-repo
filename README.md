- AWD
  - Route53 ドメイン Aレコード対応付け
  - セキュリティグループ ちゃんと見る


- Amazon Linux2
  - WebServer(Nginx) --UNIXソケット通信-- APPServer(Puma)
  - rootユーザーと一般ユーザーの区別
  - /bin    /usr/bin    /usr/local/bin
  - chown 所有者設定
  - sqlite3 yarnでインストールできる最新が古かった wgetで直接　→　make&make install
  - ```ruby;sqlite3
      gem install sqlite3 -- --with-sqlite3-include=/opt/sqlite/sqlite3/include \
   --with-sqlite3-lib=/opt/sqlite/sqlite3/lib
   ```


- Nginx
  - 設定は/etc/nginx/nginx.conf
  - エラー情報は /var/log/nginx/error.log
  - sudo service nginx start
  - APPサーバーに流すプロキシサーバーとしてNginxを使う
    ```ruby:title
    location / {
      proxy_read_timeout 300;
      proxy_connect_timeout 300;
      proxy_redirect off;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      # 上記server_name で設定した名前で指定
      proxy_pass http://puma;
    }
    ```


- Puma
  - puma.rb
  ``` ruby:title
    # port        ENV.fetch("PORT") { 3000 }
    bind "unix://#{Rails.root}/tmp/sockets/puma.sock"
  ```
  - public/ と public 違う？


- rbenv
  - rubybuild(プラグイン)
  - .ruby-version (rbenv local *** した場所に置かれる)
  - system (OSにもとから入ってるやつ？)
  - rbenv rehash
  - 


- Rails 6
  - ```ruby;title
      config.hosts << "eziezi.com" # オープンにするホストの名前
    ```
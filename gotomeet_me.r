setwd("/Users/iamnotprufrock1/Downloads/Citrix/Gotomeet_me")
USER <- 'smapp'
PASSWORD <- 'smapp'
drv <- dbDriver("Oracle")
con <- dbConnect(drv,'colbiapp','colbiapp','oidvip.ops.expertcity.com/bi')
df <- dbGetQuery(con, "select * from session_fact where product_key in
(select PRODUCTKEY from products_dim where offering = 'GoToMeeting')
and session_start_datetime >= to_date('2013-04-25','YYYY-MM-DD')")

df1 <- dbGetQuery(con, "select * from account_provisioning_fact apf
inner join
(select * from colbi.gotomeet_userprofile users
inner join etl_colbi.user_role_bridge urb
on users.userkey = urb.native_account_key) df
on apf.native_broker_acct_key = df.native_account_key")

df2 <- dbGetQuery(con,"select * from session_fact where SESSION_START_DATETIME >= to_date('2013-04-25','YYYY-MM-DD')")

merge = merge(df1,df2,by.x='')



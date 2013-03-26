kdc_setup() {
      kmasterpass=$1
      kadmpass=$2
      kdb5_util create -s -P ${kmasterpass}
      service krb5kdc start
      service kadmin start
      kadmin.local <<EOF 
        add_principal -pw $kadmpass kadmin/admin
        add_principal -pw $kadmpass hadoop/admin
        add_principal -pw $kadmpass hdfs
        add_principal -pw $kadmpass mapred
        add_principal -pw $kadmpass hbase
        quit
EOF
}

    add_client() {
      user=$1
      pass=$2
      kt=$3
      host=$4
      kadmin -p $user -w $pass <<EOF 
        add_principal -randkey host/$host
        add_principal -randkey hadoop/$host
        add_principal -randkey hdfs/$host
        add_principal -randkey mapred/$host
        add_principal -randkey hbase/$host
        add_principal -randkey zookeeper/$host
        ktadd -k $kt host/$host
        ktadd -k $kt hadoop/$host
        ktadd -k $kt hdfs/$host
        ktadd -k $kt mapred/$host
        ktadd -k $kt hbase/$host
        ktadd -k $kt zookeeper/$host
        quit
EOF
     }
KDC_MASTER_PASS="EiSei0Da"
KDC_ADMIN_PASS="Chohpet6"
HOSTNAME=`hostname --fqdn | awk '{print tolower($1)}'`
if [ "$1" = "true" ]; then
  kdc_setup $KDC_MASTER_PASS $KDC_ADMIN_PASS
  echo "Waiting 10 seconds for KDC"
  sleep 10
fi
mkdir -p /etc/hadoop/conf /etc/hbase/conf
add_client "hadoop/admin" $KDC_ADMIN_PASS /etc/hadoop/conf/hdfs.keytab $HOSTNAME
chown hdfs:hadoop /etc/hadoop/conf/hdfs.keytab
cp /etc/hadoop/conf/hdfs.keytab /etc/hadoop/conf/mapred.keytab
chown mapred:hadoop /etc/hadoop/conf/mapred.keytab
cp /etc/hadoop/conf/hdfs.keytab /etc/hbase/conf/hbase.keytab
chown hbase:hadoop /etc/hbase/conf/hbase.keytab
chmod 640 /etc/hadoop/conf/*.keytab


# The Amazon EC2 bucket for images

REGION=${REGION:-us-east-1}
#REGION=${REGION:-us-west-1}
#REGION=${REGION:-us-west-2}
#REGION=${REGION:-eu-west-1}
#REGION=${REGION:-ap-northeast-1}
#REGION=${REGION:-ap-southeast-1}
S3_BUCKET=${S3_BUCKET:-intel-hadoop-bundles-$REGION}
# Account for bucket
# We need this because S3 is returning account identifiers instead of bucket
# names.
S3_ACCOUNT=${S3_ACCOUNT:-$AWS_ACCOUNT_ID}

# The version of HBase to use and the distribution tarball location
#export HBASE_VERSION=0.94.5
#export HBASE_URL=http://www.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-security.tar.gz

export HBASE_VERSION=0.97-SNAPSHOT
#export HBASE_URL=http://www.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-security.tar.gz
export HBASE_URL=https://s3.amazonaws.com/Ram_bucket_us-east-1/hbase-0.97-SNAPSHOT.tar.gz


# The version of Hadoop to use and the distribution tarball location

#export HADOOP_VERSION=1.0.4
#export HADOOP_URL=http://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION-bin.tar.gz
export HADOOP_VERSION=2.0.3-alpha
export HADOOP_URL=http://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz


############################################################################
# Generally, users do not need to edit below

export IMAGE_VERSION="hadoop-$HADOOP_VERSION-$HBASE_VERSION"

export EC2_URL=${EC2_URL:-https://$REGION.ec2.amazonaws.com}

# SSH options used when connecting to EC2 instances.
SSH_OPTS=`echo -q -i "$EC2_ROOT_SSH_KEY" -o StrictHostKeyChecking=no -o ServerAliveInterval=30`

# EC2 command request timeout (seconds)
REQUEST_TIMEOUT=300    # 5 minutes

# Global tool options
TOOL_OPTS=`echo -K "$EC2_PRIVATE_KEY" -C "$EC2_CERT" --request-timeout $REQUEST_TIMEOUT`

BASE_AMI_VERSION="amzn-ami-pv-2013.03.rc-0.x86_64-s3"

EPEL_RPM=http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-5.noarch.rpm

JAVA_VERSION=${JAVA_VERSION:-7u17}
JAVA_RPM=https://s3.amazonaws.com/intel-hadoop-apurtell-us-east-1/jdk/jdk-$JAVA_VERSION-linux-x64_64.rpm

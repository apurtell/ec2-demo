# The Amazon EC2 bucket for images

#REGION=${REGION:-us-east-1}
REGION=${REGION:-us-west-1}
#REGION=${REGION:-us-west-2}
#REGION=${REGION:-eu-west-1}
#REGION=${REGION:-ap-northeast-1}
#REGION=${REGION:-ap-southeast-1}
S3_BUCKET=${S3_BUCKET:-tm-bundles-$REGION}
# Account for bucket
# We need this because S3 is returning account identifiers instead of bucket
# names.
S3_ACCOUNT=801535628028

# The version of HBase to use and the distribution tarball location

export HBASE_VERSION=0.94.0
export HBASE_URL=http://www.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-security.tar.gz

# The version of Hadoop to use and the distribution tarball location

export HADOOP_VERSION=1.0.2
export HADOOP_URL=http://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION-bin.tar.gz

############################################################################
# Generally, users do not need to edit below

export IMAGE_VERSION="tm-$HBASE_VERSION-$HADOOP_VERSION"

export EC2_URL=${EC2_URL:-https://$REGION.ec2.amazonaws.com}

# SSH options used when connecting to EC2 instances.
SSH_OPTS=`echo -q -i "$EC2_ROOT_SSH_KEY" -o StrictHostKeyChecking=no -o ServerAliveInterval=30`

# EC2 command request timeout (seconds)
REQUEST_TIMEOUT=300    # 5 minutes

# Global tool options
TOOL_OPTS=`echo -K "$EC2_PRIVATE_KEY" -C "$EC2_CERT" --request-timeout $REQUEST_TIMEOUT`

ARCH=x86_64

BASE_AMI_VERSION="amzn-ami-pv-2012.03.1.${ARCH}-s3"

EPEL_RPM=http://dl.fedoraproject.org/pub/epel/6/${ARCH}/epel-release-6-5.noarch.rpm

JAVA_VERSION=1.7.0_4
JAVA_RPM=http://tm-files-west.s3.amazonaws.com/jdk/jdk-${JAVA_VERSION}-linux-${ARCH}.rpm

APPSCALE_CONFIG_DIR=${HOME}/.appscale-tools
APPSCALE_CONFIG=${APPSCALE_CONFIG_DIR}/appscale_config.sh

export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/jre
export EC2_HOME=/usr/local/ec2
export PATH=${EC2_HOME}/bin:${PATH}
export EC2_REGION="${EC2_REGION:-us-east-1}"
export EC2_JVM_ARGS=-Djavax.net.ssl.trustStore=${JAVA_HOME}/lib/security/cacerts
export EUCALYPTUS_CERT=${APPSCALE_CONFIG_DIR}/cert-euca.pem

# Included in your Eucalyptus x509 credentials, not used for EC2
# Change this for Euca
export EC2_URL=https://ec2.${EC2_REGION}.amazonaws.com
export S3_URL=https://s3.amazonaws.com:443

# Download your cert*.pem and matching pk*.pem from AWS or the Euca admin console
export EC2_CERT=${APPSCALE_CONFIG_DIR}/cert.pem
export EC2_PRIVATE_KEY=${APPSCALE_CONFIG_DIR}/pk.pem

# Cut/paste your access and secret keys from AWS or the Eucalyptus admin console
export EC2_ACCESS_KEY="<< Set your EC2_ACCESS_KEY in ${APPSCALE_CONFIG} >>"
export EC2_SECRET_KEY="<< Set your EC2_SECRET_KEY in ${APPSCALE_CONFIG} >>"
export EC2_USER_ID="<< Set your EC2_USER_ID in ${APPSCALE_CONFIG} >>"

# if the user's custom configuration file exists, source it here.
[ -e ${APPSCALE_CONFIG} ] && source ${APPSCALE_CONFIG}

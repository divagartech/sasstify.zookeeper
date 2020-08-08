FROM sasstify/sasstify.base.image

ARG artifact_id
ARG version

LABEL com.sasstify.project.name = $artifact_id \
      com.sasstify.project.version = $version

ENV ZK_USER=zookeeper \
    ZK_VERSION=3.6.1
ENV ZK_DIST zookeeper-$ZK_VERSION

ENV ZK_REPO=https://www.apache.org/dist/zookeeper \
    ZK_OPT_DIR=$SASSTIFY_OPT_DIR/$ZK_DIST \
    ZK_ETC_DIR=$SASSTIFY_ETC_DIR/$ZK_DIST \
    ZK_VAR_DIR=$SASSTIFY_VAR_DIR/$ZK_DIST \
    ZK_BIN_DIR=$SASSTIFY_BIN_DIR/$ZK_DIST

ENV ZK_DATA_DIR $ZK_VAR_DIR/lib/zookeeper/data
ENV ZK_DATA_LOG_DIR $ZK_VAR_DIR/lib/zookeeper/log
ENV ZOO_LOG_DIR $ZK_VAR_DIR/log/zookeeper

ENV ZK_URL $ZK_REPO/$ZK_DIST/apache-"$ZK_DIST"-bin.tar.gz

RUN curl -fSL "$ZK_URL" -o /tmp/zookeeper.tar.gz \
     && curl -fSL "$ZK_URL.asc" -o /tmp/zookeeper.tar.gz.asc \
     && curl -fSL "$ZK_REPO/KEYS" -o /tmp/zookeeper.tar.gz.KEYS \
     && gpg --import /tmp/zookeeper.tar.gz.KEYS \
     && gpg --verify /tmp/zookeeper.tar.gz.asc \
     && tar -xvf /tmp/zookeeper.tar.gz -C $SASSTIFY_OPT_DIR/ \
     && mv $SASSTIFY_OPT_DIR/apache-zookeeper-$ZK_VERSION-bin $ZK_OPT_DIR \
     && rm /tmp/zookeeper.tar.gz* \
     && rm -rf $ZK_OPT_DIR/CHANGES.txt \
         $ZK_OPT_DIR/README.txt \
         $ZK_OPT_DIR/NOTICE.txt \
         $ZK_OPT_DIR/CHANGES.txt \
         $ZK_OPT_DIR/README_packaging.txt \
         $ZK_OPT_DIR/build.xml \
         $ZK_OPT_DIR/config \
         $ZK_OPT_DIR/conf/zoo_sample.cfg \
         $ZK_OPT_DIR/contrib \
         $ZK_OPT_DIR/dist-maven \
         $ZK_OPT_DIR/docs \
         $ZK_OPT_DIR/ivy.xml \
         $ZK_OPT_DIR/ivysettings.xml \
         $ZK_OPT_DIR/recipes \
         $ZK_OPT_DIR/src \
         $ZK_OPT_DIR/$ZK_DIST.jar.asc \
         $ZK_OPT_DIR/$ZK_DIST.jar.md5 \
         $ZK_OPT_DIR/$ZK_DIST.jar.sha1

#Copy configuration generator script to bin
COPY resources/scripts $ZK_OPT_DIR/bin/
RUN dos2unix $ZK_OPT_DIR/bin/*  \
    && chmod +x $ZK_OPT_DIR/bin/*

#Copy supervisor conf
COPY resources/supervisor-zookeeper.conf /etc/supervisor/conf.d/

# Create a user for the zookeeper process and configure file system ownership
# for nessecary directories and symlink the distribution as a user executable
RUN useradd -g sasstify $ZK_USER \
    && [ `id -u $ZK_USER` -eq 1001 ] \
    && mkdir -p $ZK_DATA_DIR $ZK_DATA_LOG_DIR $ZOO_LOG_DIR /usr/share/zookeeper /tmp/zookeeper /usr/etc/zookeeper \
    	&& chown -R "$ZK_USER:sasstify" $ZK_OPT_DIR $ZK_DATA_DIR $ZOO_LOG_DIR $ZK_DATA_LOG_DIR /tmp/zookeeper \
    	&& ln -s $ZK_OPT_DIR/conf /usr/etc/zookeeper \
    	&& ln -s $ZK_OPT_DIR/bin/* /usr/bin/ \
    	&& ln -s $ZK_OPT_DIR/lib/* /usr/share/zookeeper

EXPOSE 2888 3888 2181
